import UIKit
import Kingfisher

class PokemonTypeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var allPokemonList: [Pokemon] = []
    private var visiblePokemonList: [Pokemon] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        fetchAllPokemon()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Buscar Pokémon por nombre o tipo"
    }
    
    private func fetchAllPokemon() {
        let endpoint = "https://pokeapi.co/api/v2/pokemon?limit=151"
        
        // Mostrar indicador de actividad
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .url,
            headers: nil,
            onSuccess: { (pokemonListResponse: PokemonListResponse) in
                // Limpiar listas existentes
                self.allPokemonList.removeAll()
                self.visiblePokemonList.removeAll()
                
                // Obtener detalles de cada Pokémon
                let dispatchGroup = DispatchGroup()
                
                for pokemonEntry in pokemonListResponse.results {
                    dispatchGroup.enter()
                    self.fetchPokemonDetails(for: pokemonEntry.name) {
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    // Ordenar alfabéticamente
                    self.allPokemonList.sort { $0.name < $1.name }
                    self.visiblePokemonList = self.allPokemonList
                    
                    // Actualizar UI
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            },
            onFailure: { error in
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    
                    // Mostrar alerta de error
                    let alert = UIAlertController(title: "Error", message: "No se pudo cargar la lista de Pokémon: \(error.message)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
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
    
    private func filterPokemon(by searchText: String) {
        if searchText.isEmpty {
            visiblePokemonList = allPokemonList
        } else {
            visiblePokemonList = allPokemonList.filter { pokemon in
                // Filtrar por nombre
                let nameMatch = pokemon.name.lowercased().contains(searchText.lowercased())
                
                // Filtrar por tipo exacto
                let typeMatch = pokemon.types.contains { type in
                    type.type.name.lowercased() == searchText.lowercased()
                }
                
                return nameMatch || typeMatch
            }
        }
        tableView.reloadData()
    }
}

extension PokemonTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = visiblePokemonList.count
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
        cell.detailTextLabel?.text = pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", ")
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
        
        // Navegar a la vista de detalles
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController {
            detailVC.pokemon = selectedPokemon
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension PokemonTypeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPokemon(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        if allPokemonList.isEmpty {
            fetchAllPokemon()
            // La función fetchAllPokemon ya actualiza la UI cuando termine
        } else {
            filterPokemon(by: searchText)
        }
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        visiblePokemonList = allPokemonList
        tableView.reloadData()
    }
}
