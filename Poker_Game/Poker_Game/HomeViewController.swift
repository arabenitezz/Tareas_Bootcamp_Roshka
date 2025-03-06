import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PlayerHandButtonUIButton: UIButton!
    @IBOutlet weak var CardsUILabel: UILabel!
    @IBOutlet weak var CardsUILabel2: UILabel!
    @IBOutlet weak var ResultsUILabel: UILabel!
    @IBOutlet weak var ResultsUILabel2: UILabel!
    @IBOutlet weak var WinnerUILabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func generateNewHand(_ sender: UIButton) {
        
        let deck = Deck()
        
        let randomCards = deck.makeHand(count: 5)
        let randomCards2 = deck.makeHand(count: 5)
        
        // Mostrar todas las cartas correctamente
        CardsUILabel.text = randomCards.map { "\($0.value) \($0.suit.rawValue)" }.joined(separator: ", ")
        CardsUILabel2.text = randomCards2.map { "\($0.value) \($0.suit.rawValue)" }.joined(separator: ", ")
        
        var resultText = ""
        
        // Verificar la mano y actualizar el resultado
        if PokerHandChecker.checkStraightFlush(hand: randomCards) {
            resultText = "Escalera de color"
        } else if PokerHandChecker.checkPoker(hand: randomCards) {
            resultText = "Póker"
        } else if PokerHandChecker.checkFullHouse(hand: randomCards) {
            resultText = "Full House"
        } else if PokerHandChecker.checkFlush(hand: randomCards) {
            resultText = "Color"
        } else if PokerHandChecker.checkStraight(hand: randomCards) {
            resultText = "Escalera"
        } else if PokerHandChecker.checkThree(hand: randomCards) {
            resultText = "Trío"
        } else if PokerHandChecker.checkTwoPair(hand: randomCards) {
            resultText = "Doble Par"
        } else if PokerHandChecker.checkPair(hand: randomCards) {
            resultText = "Par"
        } else if let highCard = PokerHandChecker.checkHighCard(hand: randomCards) {
            resultText = "Carta alta: \(highCard.value) \(highCard.suit.rawValue)"
        } else {
            resultText = "Mano no reconocida"
        }
        
        // Asignar el resultado
        ResultsUILabel.text = "Tienes: \(resultText)"
        
        var resultText2 = ""
        
        // Verificar la mano y actualizar el resultado
        if PokerHandChecker.checkStraightFlush(hand: randomCards2) {
            resultText2 = "Escalera de color"
        } else if PokerHandChecker.checkPoker(hand: randomCards2) {
            resultText2 = "Póker"
        } else if PokerHandChecker.checkFullHouse(hand: randomCards2) {
            resultText2 = "Full House"
        } else if PokerHandChecker.checkFlush(hand: randomCards2) {
            resultText2 = "Color"
        } else if PokerHandChecker.checkStraight(hand: randomCards2) {
            resultText2 = "Escalera"
        } else if PokerHandChecker.checkThree(hand: randomCards2) {
            resultText2 = "Trío"
        } else if PokerHandChecker.checkTwoPair(hand: randomCards2) {
            resultText2 = "Doble Par"
        } else if PokerHandChecker.checkPair(hand: randomCards2) {
            resultText2 = "Par"
        } else if let highCard = PokerHandChecker.checkHighCard(hand: randomCards2) {
            resultText2 = "Carta alta: \(highCard.value) \(highCard.suit.rawValue)"
        } else {
            resultText2 = "Mano no reconocida"
        }
        
        // Asignar el resultado
        ResultsUILabel2.text = "Tienes: \(resultText2)"
        
        // Determinar el ganador
        
        let winnerMessage = verifyWinner(resultText1: resultText, resultText2: resultText2)
        
        WinnerUILabel.text = winnerMessage
    }
    
}




