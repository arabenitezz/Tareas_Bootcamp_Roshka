import Foundation

class PokerHandChecker {
    
    static func checkStraightFlush(hand: [Card]) -> Bool {
        // mismo palo
        guard hand.allSatisfy({ $0.suit == hand.first?.suit }) else { return false }
        
        // obtener los valores de las cartas y convertirlos a números
        let values = hand.map { Card.valueToInt(value: $0.value) }.sorted()
        
        // verificar si los valores están en secuencia
        let isSequential = values == Array(values[0]...values[0] + 4)
        
        // verificar el caso especial del As como 14
        let isSequentialWithAceHigh = values == [1, 2, 3, 4, 5] || values == [10, 11, 12, 13, 14]
        
        return isSequential || isSequentialWithAceHigh
    }
    
    func checkPoker(hand: [Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // verificar si algun valor aparece 4 veces
        return valueCounts.values.contains(4)
        
    }
    
    func checkFullHouse(hand: [Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // verificar si algun valor aparece 3 veces y otro 2 veces
        return valueCounts.values.contains(3) && valueCounts.values.contains(2)
        
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
