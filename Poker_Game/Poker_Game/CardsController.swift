import Foundation

// definimos los palos con un Enum
enum Suit: String {
    case espada = "♠️"
    case trebol = "♣️"
    case corazon = "♥️"
    case diamante = "♦️"
}

// definimos la clase Card con un inicializador
class Card {
    let value: String
    let suit: Suit
    
    init(value: String, suit: Suit) {
        self.value = value
        self.suit = suit
    }
}

// extension de card para manejar valores de las letras

extension Card {
    // Función para convertir valores de cartas a números
    static func valueToInt(value: String) -> Int {
        let valueMap: [String: Int] = [
            "A": 1,
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9,
            "T": 10,
            "J": 11,
            "Q": 12,
            "K": 13,
        ]
        return valueMap[value] ?? 0
    }
}

// clase Deck para la baraja completa
class Deck {
    var cards: [Card] = []
    
    init() {
        let values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
        let suits: [Suit] = [.espada, .trebol, .corazon, .diamante]
        
        // Generamos todas las cartas
        for suit in suits {
            for value in values {
                cards.append(Card(value: value, suit: suit))
            }
        }
    }
    
}


extension Deck {
    func makeHand(count: Int) -> [Card] {
        guard count <= cards.count else {
            return []
        }
        return Array(cards.shuffled().prefix(count))
    }
}

