struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprites
    let types: [PokemonType]
    let weight: Int
    let height: Int
    
    struct Sprites: Codable {
        let other: Other
        
        struct Other: Codable {
            let officialArtwork: OfficialArtwork
            
            struct OfficialArtwork: Codable {
                let frontDefault: String
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
        }
    }
    
    struct PokemonType: Codable {
        let slot: Int
        let type: TypeDetails
        
        struct TypeDetails: Codable {
            let name: String
        }
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonEntry]
    
    struct PokemonEntry: Codable {
        let name: String
        let url: String
    }
}

struct PokemonTypeSection {
    var typeName: String
    var pokemons: [Pokemon]
}

struct PokemonTypeResponse: Codable {
    let pokemon: [PokemonTypeEntry]
    
    struct PokemonTypeEntry: Codable {
        let pokemon: PokemonInfo
        let slot: Int
        
        struct PokemonInfo: Codable {
            let name: String
            let url: String
        }
    }
}


