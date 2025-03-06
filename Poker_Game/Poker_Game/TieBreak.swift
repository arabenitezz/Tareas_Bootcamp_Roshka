import Foundation

class TieBreaker {
    
    // Función principal para resolver empates
    static func resolveTie(hand1: [Card], hand2: [Card], handType: HandValues) -> String {
        switch handType {
        case .straightFlush, .straight:
            return resolveStraightTie(hand1: hand1, hand2: hand2)
        case .poker:
            return resolveGroupTie(hand1: hand1, hand2: hand2, groupSize: 4)
        case .fullHouse:
            // Para full house, primero comparamos el trio
            let trioCompare = resolveGroupTie(hand1: hand1, hand2: hand2, groupSize: 3)
            if trioCompare != "Empate" {
                return trioCompare
            }
            // Si el trio es igual, comparamos el par
            return resolveGroupTie(hand1: hand1, hand2: hand2, groupSize: 2)
        case .flush, .highCard:
            return resolveHighCardTie(hand1: hand1, hand2: hand2)
        case .threeOfAKind:
            return resolveGroupTie(hand1: hand1, hand2: hand2, groupSize: 3)
        case .twoPair:
            return resolveTwoPairTie(hand1: hand1, hand2: hand2)
        case .pairA:
            return resolveGroupTie(hand1: hand1, hand2: hand2, groupSize: 2)
        }
    }
    
    // Funcion para obtener el valor numerico de una carta (As alto = 14)
    private static func getCardValue(_ card: Card) -> Int {
        let value = Card.valueToInt(value: card.value)
        return (card.value == "A") ? 14 : value
    }
    
    // Obtiene valores ordenados de mayor a menor
    private static func getSortedValues(_ hand: [Card]) -> [Int] {
        return hand.map { getCardValue($0) }.sorted(by: >)
    }
    
    // Resolver empate en escalera o escalera de color
    private static func resolveStraightTie(hand1: [Card], hand2: [Card]) -> String {
        // Verificar escaleras bajas (A-5-4-3-2)
        let values1 = getSortedValues(hand1)
        let values2 = getSortedValues(hand2)
        
        let isLowStraight1 = Set(values1).isSuperset(of: [14, 5, 4, 3, 2])
        let isLowStraight2 = Set(values2).isSuperset(of: [14, 5, 4, 3, 2])
        
        if isLowStraight1 && !isLowStraight2 {
            return "Jugador 2 gana"  // Escalera alta gana
        } else if !isLowStraight1 && isLowStraight2 {
            return "Jugador 1 gana"  // Escalera alta gana
        } else if isLowStraight1 && isLowStraight2 {
            return "Empate"  // Ambas son escaleras bajas
        }
        
        // Comparar carta mas alta de cada escalera
        let highCard1 = values1.first ?? 0
        let highCard2 = values2.first ?? 0
        
        if highCard1 > highCard2 {
            return "Jugador 1 gana"
        } else if highCard1 < highCard2 {
            return "Jugador 2 gana"
        } else {
            return "Empate"
        }
    }
    
    // Resuelve empates para grupos de cartas (pares, trios, poker)
    private static func resolveGroupTie(hand1: [Card], hand2: [Card], groupSize: Int) -> String {
        // Obtener los valores de los grupos
        let valueCounts1 = Dictionary(grouping: hand1, by: { $0.value })
        let valueCounts2 = Dictionary(grouping: hand2, by: { $0.value })
        
        let groupValue1 = valueCounts1.first(where: { $0.value.count == groupSize })?.key ?? ""
        let groupValue2 = valueCounts2.first(where: { $0.value.count == groupSize })?.key ?? ""
        
        let groupInt1 = getCardValue(Card(value: groupValue1, suit: .espada))
        let groupInt2 = getCardValue(Card(value: groupValue2, suit: .espada))
        
        if groupInt1 > groupInt2 {
            return "Jugador 1 gana"
        } else if groupInt1 < groupInt2 {
            return "Jugador 2 gana"
        } else {
            // Si el grupo es del mismo valor, comparamos las cartas restantes
            let kickers1 = hand1.filter { $0.value != groupValue1 }.map { getCardValue($0) }.sorted(by: >)
            let kickers2 = hand2.filter { $0.value != groupValue2 }.map { getCardValue($0) }.sorted(by: >)
            
            return compareKickers(kickers1, kickers2)
        }
    }
    
    // Resolver empate en doble par
    private static func resolveTwoPairTie(hand1: [Card], hand2: [Card]) -> String {
        // Obtener los valores de los pares
        let valueCounts1 = Dictionary(grouping: hand1, by: { $0.value })
            .filter { $0.value.count == 2 }
        let valueCounts2 = Dictionary(grouping: hand2, by: { $0.value })
            .filter { $0.value.count == 2 }
        
        // Obtener los valores de los pares y ordenarlos de mayor a menor
        let pairValues1 = valueCounts1.keys.map { getCardValue(Card(value: $0, suit: .espada)) }.sorted(by: >)
        let pairValues2 = valueCounts2.keys.map { getCardValue(Card(value: $0, suit: .espada)) }.sorted(by: >)
        
        // Comparar los pares en orden
        for i in 0..<min(pairValues1.count, pairValues2.count) {
            if pairValues1[i] > pairValues2[i] {
                return "Jugador 1 gana"
            } else if pairValues1[i] < pairValues2[i] {
                return "Jugador 2 gana"
            }
        }
        
        // Si los pares son iguales, comparar la carta restante
        let kicker1 = hand1.first(where: { card in !valueCounts1.keys.contains(card.value) })
        let kicker2 = hand2.first(where: { card in !valueCounts2.keys.contains(card.value) })
        
        let kickerValue1 = kicker1 != nil ? getCardValue(kicker1!) : 0
        let kickerValue2 = kicker2 != nil ? getCardValue(kicker2!) : 0
        
        if kickerValue1 > kickerValue2 {
            return "Jugador 1 gana"
        } else if kickerValue1 < kickerValue2 {
            return "Jugador 2 gana"
        } else {
            return "Empate"
        }
    }
    
    // Comparar listas de kickers
    private static func compareKickers(_ kickers1: [Int], _ kickers2: [Int]) -> String {
        for i in 0..<min(kickers1.count, kickers2.count) {
            if kickers1[i] > kickers2[i] {
                return "Jugador 1 gana"
            } else if kickers1[i] < kickers2[i] {
                return "Jugador 2 gana"
            }
        }
        return "Empate"
    }
    
    // Resolver empate con carta alta o color
    private static func resolveHighCardTie(hand1: [Card], hand2: [Card]) -> String {
        let values1 = getSortedValues(hand1)
        let values2 = getSortedValues(hand2)
        
        return compareKickers(values1, values2)
    }
}
