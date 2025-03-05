import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deck = Deck()
        let randomCards = deck.makeHand(count: 5)
        
        for card in randomCards {
            print("Carta: \(card.value) de \(card.suit)")
        }
    
    }
}

// definimos los palos con un Enum
enum Suit: String {
    case espada = "S"
    case trebol = "C"
    case corazon = "H"
    case diamante = "D"
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



