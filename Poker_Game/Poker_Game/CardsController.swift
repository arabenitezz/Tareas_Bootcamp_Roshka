import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deck = Deck()
        let randomCards = deck.makeHand(count: 5)
        
        for card in randomCards {
            print("Carta: \(card.value) de \(card.suit)")
            
        }
            
            // Verificar manos
            if PokerHandChecker.checkStraightFlush(hand: randomCards) {
                print("¡Tienes un Straight Flush!")
            } else if PokerHandChecker.checkPoker(hand: randomCards) {
                print("¡Tienes un Póker!")
            } else if PokerHandChecker.checkFullHouse(hand: randomCards) {
                print("¡Tienes un Full House!")
            } else if PokerHandChecker.checkFlush(hand: randomCards) {
                print("¡Tienes un Flush!")
            } else if PokerHandChecker.checkStraight(hand: randomCards) {
                print("¡Tienes un Straight!")
            } else if PokerHandChecker.checkThree(hand: randomCards) {
                print("¡Tienes un Trío!")
            } else if PokerHandChecker.checkTwoPair(hand: randomCards) {
                print("¡Tienes dos pares!")
            } else if PokerHandChecker.checkPair(hand: randomCards) {
                print("¡Tienes un par!")
            } else if let highCard = PokerHandChecker.checkHighCard(hand: randomCards) {
                print("Tu carta alta es: \(highCard.value) de \(highCard.suit)")
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



