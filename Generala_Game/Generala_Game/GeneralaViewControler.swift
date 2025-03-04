import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        makeHand()
        print("Dados: \(generalaHand)")
        verifyHand()
    }
    
    var firstDice = Int.random(in: 1...6)
    var secondDice = Int.random(in: 1...6)
    var thirdDice = Int.random(in: 1...6)
    var fourthDice = Int.random(in: 1...6)
    var fifthDice = Int.random(in: 1...6)
    
    var generalaHand = [Int]()
    
    func makeHand() {
        generalaHand = [firstDice, secondDice, thirdDice, fourthDice, fifthDice]
    }
    
    func verifyHand() {
        if verifyGenerala() {
            print("¡Tenés una Generala!")
        } else {
            print("No es Generala")
        }
    }
    
    func verifyGenerala() -> Bool {
    
        return Set(generalaHand).count == 1
    }
    
}
    


