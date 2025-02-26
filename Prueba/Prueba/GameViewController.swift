//
//  GameViewController.swift
//  Prueba
//
//  Created by Bootcamp on 2/26/25.
//

import UIKit
import Combine
import Foundation

class GameViewController: UIViewController {


        @IBOutlet weak var timerLabel: UILabel!
        @IBOutlet weak var scoreLabel: UILabel!
        @IBOutlet weak var gameContainer: UIView!
        @IBOutlet weak var ballButton: UIButton!
        private var timerConnector: AnyCancellable?
        private var timeRemaining: TimeInterval = 30
        private var endDate: Date?
        private var score = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            timerLabel.text = "30"
            scoreLabel.text = "Puntaje: 0"
            ballButton.isHidden = true
        }

        @IBAction func startTimerButtonTapped(_ sender: UIButton) {
            startGame()
        }

        private func startGame() {
            score = 0
            scoreLabel.text = "Puntaje: \(score)"
            timeRemaining = 30
            endDate = Date().addingTimeInterval(timeRemaining)
            
            ballButton.isHidden = false
            // func para mover la pelota
            
            timerConnector?.cancel()
            timerConnector = Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink{ [weak self] currentDate in
                    guard let self, let endDate else { return }
                    
                    let remaining = endDate.timeIntervalSince(currentDate)
                    if remaining > 0 {
                        self.timeRemaining = remaining
                        self.timerLabel.text = "\(Int(remaining))"
                    } else {
                        // funcion para terminar el juego
                    }
                    
                }
 
        }
    }

