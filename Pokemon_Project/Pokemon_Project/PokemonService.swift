import UIKit

class PokemonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPokemon()
    }

    func fetchPokemon() {
    
        let endpoint = "https://pokeapi.co/api/v2/pokemon/25"

        // Realizar la solicitud
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (pokemon: Pokemon) in
                // Manejar la respuesta exitosa
                print("Nombre: \(pokemon.name)")
                print("Número en la Pokédex: \(pokemon.id)")
                print("Imagen: \(pokemon.sprites.other.officialArtwork.frontDefault)")
            },
            onFailure: { error in
                // Manejar el error
                print("Error: \(error.message)")
            }
        )
    }
}

