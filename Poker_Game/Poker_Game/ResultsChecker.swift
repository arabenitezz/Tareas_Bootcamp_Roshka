import Foundation

// definir los valores de las cartas

enum HandValues: Int {
    case highCard = 1
    case pair = 2
    case twoPair = 3
    case threeOfAKind = 4
    case straight = 5
    case flush = 6
    case fullHouse = 7
    case poker = 8
    case straightFlush = 9
}

// convertir los resultados en text a los valores del enum

func HandRank(from resultText: String) -> HandValues {
    
    switch resultText {
    case "Escalera de color":
        return .straightFlush
    
    case "Poker":
        return .poker
        
    case "Full House":
        return .fullHouse
        
    case "Color":
        return .flush
        
    case "Escalera":
        return .straight
        
    case "Trio":
        return .threeOfAKind
        
    case "Doble Par":
        return .twoPair
        
    case "Par":
        return .pair
        
    default:
        return .highCard
    }
    
}

// verificar al ganador

func verifyWinner(resultText1: String, resultText2: String) -> String {
    
    let handRank1 = HandRank(from: resultText1)
    let handRank2 = HandRank(from: resultText2)
    
    if handRank1.rawValue > handRank2.rawValue {
        return "Jugador 1 gana con \(handRank1)"
    } else if handRank2.rawValue > handRank1.rawValue {
        return "Jugador 2 gana con \(handRank2)"
    } else {
        return "empate"
    }
}



