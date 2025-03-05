import Foundation

class PokerHandChecker {

    static func checkStraightFlush(hand: [Card]) -> Bool {
        // mismo palo
        guard hand.allSatisfy({ $0.suit == hand.first?.suit }) else { return false }
        
        // obtener los valores de las cartas y convertirlos a números
        let values = hand.map { Card.valueToInt(value: $0.value) }.sorted()
        
        // Verificar si los valores están en secuencia
        let isSequential = values == Array(values[0]...values[0] + 4)
        
        // Verificar el caso especial del As como 14
        let isSequentialWithAceHigh = values == [1, 2, 3, 4, 5] || values == [10, 11, 12, 13, 14]
        
        return isSequential || isSequentialWithAceHigh
    }
    
    func checkPoker(hand: [Card]) -> Bool {
        return false
        
    }

    func checkFullHouse(hand: [Card]) -> Bool {
        return false
        
    }

    func checkFlush(hand: [Card]) -> Bool {
        return false
        
    }

    func checkStraight(hand: [Card]) -> Bool {
        return false
        
    }

    func checkThree(hand: [Card]) -> Bool {
        return false
        
    }

    func checkTwoPair(hand:[Card]) -> Bool {
        return false
        
    }

    func checkPair(hand:[Card]) -> Bool {
        return false
        
    }

    func checkHighCard(hand:[Card]) -> Bool {
        return false
        
    }

}
