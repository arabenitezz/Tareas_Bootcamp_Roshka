import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

// definimos los palos con un Enum
enum Suit: String {
    case spades = "S"
    case clubs = "C"
    case hearts = "H"
    case diamonds = "D"
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
        let suits: [Suit] = [.spades, .clubs, .hearts, .diamonds]
        
        // Generamos todas las cartas
        for suit in suits {
            for value in values {
                cards.append(Card(value: value, suit: suit))
            }
        }
    }
    
}


