import Foundation

class PokerHandChecker {
    
    static func checkStraightFlush(hand: [Card]) -> Bool {
        // mismo palo
        guard hand.allSatisfy({ $0.suit == hand.first?.suit }) else { return false }
        
        // obtener los valores de las cartas y convertirlos a números
        let values = hand.map { Card.valueToInt(value: $0.value) }.sorted()
        
        // Verificamos escalera baja (A-2-3-4-5) antes de cualquier otra cosa
        if values == [1, 2, 3, 4, 5] {
            return true
        }
        
        // Si hay un As (1), intentamos una nueva lista con el As como 14
        let valuesWithAceHigh = values.map { $0 == 1 ? 14 : $0 }.sorted()
        
        // Verificamos si hay una secuencia normal
        let isSequential = values == Array(values[0]...values[0] + 4)
        let isSequentialWithAceHigh = valuesWithAceHigh == [10, 11, 12, 13, 14]
        
        return isSequential || isSequentialWithAceHigh
    }
    
    static func checkPoker(hand: [Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // verificar si algun valor aparece 4 veces
        return valueCounts.values.contains(4)
        
    }
    
    static func checkFullHouse(hand: [Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // verificar si algun valor aparece 3 veces y otro 2 veces
        return valueCounts.values.contains(3) && valueCounts.values.contains(2)
        
    }
    
    static func checkFlush(hand: [Card]) -> Bool {
        
        // mismo palo
        guard let firstSuit = hand.first?.suit else { return false }
        return hand.allSatisfy { $0.suit == firstSuit }
        
    }
    
    static func checkStraight(hand: [Card]) -> Bool {
        let values = hand.map { Card.valueToInt(value: $0.value) }.sorted()
        
        // Verificamos escalera baja (A-2-3-4-5) antes de cualquier otra cosa
        if values == [1, 2, 3, 4, 5] {
            return true
        }
        
        // Si hay un As (1), intentamos una nueva lista con el As como 14
        let valuesWithAceHigh = values.map { $0 == 1 ? 14 : $0 }.sorted()
        
        // Verificamos si hay una secuencia normal
        let isSequential = values == Array(values[0]...values[0] + 4)
        let isSequentialWithAceHigh = valuesWithAceHigh == [10, 11, 12, 13, 14]
        
        return isSequential || isSequentialWithAceHigh
    }
    
    
    static func checkThree(hand: [Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // verificar si algun valor aparece 3 veces
        return valueCounts.values.contains(3)
        
    }
    
    static func checkTwoPair(hand:[Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // Contar cuantos pares hay
        let pairsCount = valueCounts.values.filter { $0 == 2 }.count
        return pairsCount == 2
        
    }
    
    static func checkPair(hand:[Card]) -> Bool {
        
        // contador de frecuencia
        
        let valueCounts = Dictionary(grouping: hand, by: { $0.value })
            .mapValues { $0.count }
        
        // verificar si algun valor aparece 2 veces
        return valueCounts.values.contains(2)
        
    }
    
    static func checkHighCard(hand: [Card]) -> Card? {
        
        func getCardValue(_ card: Card) -> Int {
            let baseValue = Card.valueToInt(value: card.value)
            return (card.value == "A") ? 14: baseValue
        }
        
        return hand.max(by: { getCardValue($0) < getCardValue($1)})
    }
    
}

    
