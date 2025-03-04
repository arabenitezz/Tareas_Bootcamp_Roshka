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
            print("tenes una generala")
            
        } else if  verifyPoker() {
            print("tenes poker")
            
        } else if verifyFull() {
            print("tenes full")
            
        } else if verifyEscalera() {
            print("tenes escalera")
        } else {
            print("no tenes nada")
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
    
        let sortedHand = generalaHand.sorted()
        
        for i in 0..<sortedHand.count - 1 {
            if sortedHand[i + 1] - sortedHand[i] != 1 {
                return false
            }
        }
        
        return true
    }
}

