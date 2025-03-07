import Alamofire

class PokeAPIService {
    static let shared = PokeAPIService()

    private init() {}

    func fetchPokemon(by nameOrId: String, completion: @escaping (Result<Pokemon, AFError>) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon/\(nameOrId.lowercased())/"
        AF.request(url).responseDecodable(of: Pokemon.self) { response in
            completion(response.result)
        }
    }
}
