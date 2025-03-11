import UIKit
import Kingfisher

class PokemonTypeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let pickerView = UIPickerView()
    private var allPokemonList: [Pokemon] = [] // Lista completa de Pokemon del tipo seleccionado
    private var visiblePokemonList: [Pokemon] = [] // Lista filtrada para mostrar en la tabla
    private var pokemonNames: [String] = [] // Nombres de Pokemon para el PickerView
    private var selectedPokemon: Pokemon? // Pokémon seleccionado en el PickerView
    private var currentPokemonType: String = "normal" // Tipo por defecto para cargar al inicio
    private var isSearchingType: Bool = false // Para distinguir entre búsqueda de tipo y filtrado por nombre
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupTableView()
        setupSearchBar()
        
        // Cargar Pokémon de tipo "normal" al iniciar
        fetchPokemon(byType: currentPokemonType)
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        pokemonTextField.inputAccessoryView = toolbar
        pokemonTextField.inputView = pickerView
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Buscar tipo o nombre de Pokémon"
    }
    
    @objc private func dismissPicker() {
        view.endEditing(true)
        if let selectedPokemon = selectedPokemon {
            filterPokemon(byName: selectedPokemon.name)
        }
    }
    
    private func filterPokemon(byName name: String?) {
        guard let name = name, !name.isEmpty else {
            // Si no hay nombre, mostrar todos los Pokémon
            visiblePokemonList = allPokemonList
            tableView.reloadData()
            return
        }
        
        visiblePokemonList = allPokemonList.filter { $0.name.lowercased().contains(name.lowercased()) }
        tableView.reloadData()
    }
    
    private func fetchPokemon(byType type: String) {
        let endpoint = "https://pokeapi.co/api/v2/type/\(type.lowercased())"
        currentPokemonType = type.lowercased()
        
        // Mostrar indicador de actividad
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (typeResponse: PokemonTypeResponse) in
                // Limpiar listas existentes
                self.allPokemonList.removeAll()
                self.visiblePokemonList.removeAll()
                self.pokemonNames.removeAll()
                
                self.pokemonNames = typeResponse.pokemon.map { $0.pokemon.name.capitalized }
                self.pickerView.reloadAllComponents()
                
                // Obtener detalles de cada Pokemon
                let dispatchGroup = DispatchGroup()
                
                for pokemonEntry in typeResponse.pokemon {
                    dispatchGroup.enter()
                    self.fetchPokemonDetails(for: pokemonEntry.pokemon.name.lowercased()) {
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    // Ordenar alfabéticamente
                    self.allPokemonList.sort { $0.name < $1.name }
                    
                    // Actualizar lista filtrada
                    if let searchText = self.searchBar.text, !searchText.isEmpty, !self.isSearchingType {
                        // Si hay texto en el searchBar y no estamos buscando un tipo,
                        // filtramos por ese texto
                        self.visiblePokemonList = self.allPokemonList.filter {
                            $0.name.lowercased().contains(searchText.lowercased())
                        }
                    } else {
                        // Si no, mostramos todos los Pokémon del tipo
                        self.visiblePokemonList = self.allPokemonList
                    }
                    
                    // Actualizar UI
                    if !self.pokemonNames.isEmpty {
                        self.pokemonTextField.text = self.pokemonNames.first
                    }
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    
                    // Resetear el flag
                    self.isSearchingType = false
                }
            },
            onFailure: { error in
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    
                    // Mostrar alerta de error
                    let alert = UIAlertController(title: "Error", message: "No se pudo encontrar el tipo de Pokémon: \(error.message)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                    
                    // Resetear el flag
                    self.isSearchingType = false
                }
            }
        )
    }
    
    private func fetchPokemonDetails(for pokemonName: String, completion: @escaping () -> Void) {
        let endpoint = "https://pokeapi.co/api/v2/pokemon/\(pokemonName)"
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (pokemon: Pokemon) in
                DispatchQueue.main.async {
                    self.allPokemonList.append(pokemon)
                }
                completion()
            },
            onFailure: { error in
                print("Error fetching details for \(pokemonName): \(error.message)")
                completion()
            }
        )
    }
}

extension PokemonTypeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokemonNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemonNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < pokemonNames.count else { return }
        
        let pokemonName = pokemonNames[row]
        pokemonTextField.text = pokemonName
        selectedPokemon = allPokemonList.first { $0.name.capitalized == pokemonName }
    }
}

extension PokemonTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = visiblePokemonList.count
        // Mostrar mensaje si no hay resultados
        if count == 0 {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
            messageLabel.text = "No se encontraron Pokémon"
            messageLabel.textAlignment = .center
            messageLabel.textColor = .gray
            tableView.backgroundView = messageLabel
        } else {
            tableView.backgroundView = nil
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        guard indexPath.row < visiblePokemonList.count else {
            return cell
        }
        
        let pokemon = visiblePokemonList[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        // Limpiar imagen anterior para evitar reutilización incorrecta
        cell.imageView?.image = UIImage(systemName: "questionmark.circle")
        
        if let imageUrl = URL(string: pokemon.sprites.other.officialArtwork.frontDefault) {
            cell.imageView?.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "questionmark.circle"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.row < visiblePokemonList.count else { return }
        let selectedPokemon = visiblePokemonList[indexPath.row]
        print("Selected Pokémon: \(selectedPokemon.name)")

    }
}

extension PokemonTypeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Si el texto está vacío, mostrar todos los Pokémon del tipo actual
            visiblePokemonList = allPokemonList
        } else {
            // Filtrar los Pokémon del tipo actual por nombre
            visiblePokemonList = allPokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        isSearchingType = false
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        isSearchingType = true
        
        // Buscar Pokémon por tipo
        fetchPokemon(byType: searchText)
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        // Mostrar todos los Pokémon del tipo actual
        visiblePokemonList = allPokemonList
        tableView.reloadData()
    }
}
