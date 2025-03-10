import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprites
    
    struct Sprites: Codable {
        let other: Other
        
        struct Other: Codable {
            let officialArtwork: OfficialArtwork
            
            struct OfficialArtwork: Codable {
                let frontDefault: String
                
                // Mapeamos las claves del JSON a nombres más Swift-friendly
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
        }
    }
}

struct PokemonTypeResponse: Codable {
    let pokemon: [PokemonEntry]
    
    struct PokemonEntry: Codable {
        let pokemon: PokemonReference
        
        struct PokemonReference: Codable {
            let name: String
        }
    }
}
