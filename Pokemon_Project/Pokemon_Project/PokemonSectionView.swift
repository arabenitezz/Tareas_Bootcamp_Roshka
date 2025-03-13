import UIKit
import Kingfisher

class PokemonTypeSectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonSections: [PokemonTypeSection] = []
    var expandedSections: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchPokemonByType()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
    }
    
    private func fetchPokemonByType() {
        let types = ["water", "fire", "grass", "electric", "flying"]
        
        for type in types {
            fetchPokemon(for: type) { pokemons in
                let section = PokemonTypeSection(typeName: type.capitalized, pokemons: pokemons)
                self.pokemonSections.append(section)
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchPokemon(for type: String, completion: @escaping ([Pokemon]) -> Void) {
        let endpoint = "https://pokeapi.co/api/v2/type/\(type)"
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (typeResponse: PokemonTypeResponse) in
                var pokemons: [Pokemon] = []
                let dispatchGroup = DispatchGroup()
                
                // Limitar a 5 Pokémon por tipo
                let limitedPokemonEntries = Array(typeResponse.pokemon.prefix(5))
                
                for pokemonEntry in limitedPokemonEntries {
                    dispatchGroup.enter()
                    self.fetchPokemonDetails(for: pokemonEntry.pokemon.name) { pokemon in
                        pokemons.append(pokemon)
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(pokemons)
                }
            },
            onFailure: { error in
                print("Error fetching Pokémon for type \(type): \(error.message)")
                completion([])
            }
        )
    }
    
    private func fetchPokemonDetails(for pokemonName: String, completion: @escaping (Pokemon) -> Void) {
        let endpoint = "https://pokeapi.co/api/v2/pokemon/\(pokemonName)"
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (pokemon: Pokemon) in
                completion(pokemon)
            },
            onFailure: { error in
                print("Error fetching details for \(pokemonName): \(error.message)")
            }
        )
    }
    
    // Método para manejar el toque en el encabezado
    @objc func headerTapped(_ sender: UITapGestureRecognizer) {
        guard let headerView = sender.view else { return }
        let section = headerView.tag
        
        // Alternamos el estado de la sección
        if expandedSections.contains(section) {
            expandedSections.remove(section)
        } else {
            expandedSections.insert(section)
        }
        
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

extension PokemonTypeSectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pokemonSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < pokemonSections.count else { return 0 }
        
        // Si la sección está expandida, muestra las filas, sino, no muestra ninguna
        return expandedSections.contains(section) ? pokemonSections[section].pokemons.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonSections[indexPath.section].pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        
        if let imageUrl = URL(string: pokemon.sprites.other.officialArtwork.frontDefault) {
            cell.imageView?.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "questionmark.circle"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < pokemonSections.count else { return nil }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0) // #FFCC00
        
        // Etiqueta para el nombre del tipo
        let typeLabel = UILabel(frame: CGRect(x: 15, y: 0, width: headerView.frame.width - 50, height: 40))
        typeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        typeLabel.textColor = .white
        typeLabel.text = pokemonSections[section].typeName.capitalized
        
        // Indicador de sección expandida/colapsada
        let indicatorLabel = UILabel(frame: CGRect(x: headerView.frame.width - 40, y: 0, width: 40, height: 40))
        indicatorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        indicatorLabel.textColor = .white
        indicatorLabel.text = expandedSections.contains(section) ? "▼" : "▶"
        indicatorLabel.textAlignment = .center
        
        headerView.addSubview(typeLabel)
        headerView.addSubview(indicatorLabel)
        
        // Añadir gesto de toque para expandir/colapsar
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section // Usamos el tag para identificar qué sección fue tocada
        headerView.isUserInteractionEnabled = true
        
        return headerView
    }
    
    // establece la altura del header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // establece la altura de las filas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedPokemon = pokemonSections[indexPath.section].pokemons[indexPath.row]
        
        // Navegar a la vista de detalles
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController {
            detailVC.pokemon = selectedPokemon
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
