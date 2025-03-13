import UIKit
import Kingfisher

class PokemonTypeSectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonSections: [PokemonTypeSection] = []
    
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
}

extension PokemonTypeSectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pokemonSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonSections[section].pokemons.count
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        lbl.text = pokemonSections[section].typeName.capitalized
        view.addSubview(lbl)
        
        return view
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
