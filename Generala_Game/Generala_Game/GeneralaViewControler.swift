import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var HandsResultsUILabel: UILabel!
    @IBOutlet weak var ShuffleButtonUIButton: UIButton!
    @IBOutlet weak var DiceResultsUILabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        makeHand()
        verifyHand()
    }
    
    var generalaHand = [Int]()
    
    func makeHand() {
        generalaHand = (0..<5).map { _ in Int.random(in: 1...6) }
    }
    
    func verifyHand() {
        
        DiceResultsUILabel.text = "Dados: \(generalaHand)"
        
        if verifyGenerala() {
            HandsResultsUILabel.text = "Tenes generala 🎲"
            
        } else if  verifyPoker() {
            HandsResultsUILabel.text = "Tenes poker 🃏"
            
        } else if verifyFull() {
            HandsResultsUILabel.text = "Tenes full 🔥"
            
        } else if verifyEscalera() {
            HandsResultsUILabel.text = "Tenes escalera 🪜 :D"
            
        } else {
            HandsResultsUILabel.text = "No tenes nada :("
        }
    }
    
    func verifyGenerala() -> Bool {
        return Set(generalaHand).count == 1
    }
    
    func verifyPoker() -> Bool {
        let frequencies = generalaHand.reduce(into: [:]) { counts, number in
            counts[number, default: 0] += 1
        }
        
        return frequencies.values.contains(4)
    }
    
    func verifyFull() -> Bool {
        let frequencies = generalaHand.reduce(into: [:]) { counts, number in
            counts[number, default: 0] += 1
        }
        
        return frequencies.values.contains(3) && frequencies.values.contains(2)
    }
    
    func verifyEscalera() -> Bool {
        
        let sortedHand = Set(generalaHand).sorted()
        
        if sortedHand == [1, 2, 3, 4, 5] || sortedHand == [2, 3, 4, 5, 6] {
            return true
        }
        
        return false
    }
}

