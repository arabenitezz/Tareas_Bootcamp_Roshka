import UIKit
import Kingfisher

class PokemonTypeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let pickerView = UIPickerView()
    private var pokemonList: [Pokemon] = [] // Lista de Pokémon del tipo seleccionado
    private var pokemonNames: [String] = [] // Nombres de Pokémon para el PickerView
    private var selectedPokemon: Pokemon? // Pokémon seleccionado en el PickerView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupTableView()
        setupSearchBar()
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
    }
    
    @objc private func dismissPicker() {
        view.endEditing(true)
        updateTableView()
    }
    
    private func updateTableView() {
        if let selectedPokemon = selectedPokemon {
            // Mostrar solo el Pokémon seleccionado
            pokemonList = [selectedPokemon]
        } else {
            // Mostrar todos los Pokémon del tipo
        }
        tableView.reloadData()
    }
    
    private func fetchPokemon(byType type: String) {
        let endpoint = "https://pokeapi.co/api/v2/type/\(type.lowercased())"
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (typeResponse: PokemonTypeResponse) in
                DispatchQueue.main.async {
                    self.pokemonNames = typeResponse.pokemon.map { $0.pokemon.name }
                    self.pokemonTextField.text = self.pokemonNames.first // Valor por defecto
                    self.pickerView.reloadAllComponents()
                    
                    // Obtener detalles de cada Pokémon
                    self.fetchPokemonDetails(for: self.pokemonNames)
                }
            },
            onFailure: { error in
                print("Error: \(error.message)")
            }
        )
    }
    
    private func fetchPokemonDetails(for pokemonNames: [String]) {
        pokemonNames.forEach { name in
            let endpoint = "https://pokeapi.co/api/v2/pokemon/\(name)"
            
            HTTPClient.request(
                endpoint: endpoint,
                method: .get,
                encoding: .json,
                headers: nil,
                onSuccess: { (pokemon: Pokemon) in
                    DispatchQueue.main.async {
                        self.pokemonList.append(pokemon)
                        self.tableView.reloadData()
                    }
                },
                onFailure: { error in
                    print("Error: \(error.message)")
                }
            )
        }
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
        pokemonTextField.text = pokemonNames[row]
        selectedPokemon = pokemonList.first { $0.name == pokemonNames[row] }
    }
}

extension PokemonTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonList[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        if let imageUrl = URL(string: pokemon.sprites.other.officialArtwork.frontDefault) {
            cell.imageView?.kf.setImage(with: imageUrl)
        }
        
        return cell
    }
}

extension PokemonTypeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let type = searchBar.text, !type.isEmpty else { return }
        fetchPokemon(byType: type)
        searchBar.resignFirstResponder()
    }
}
