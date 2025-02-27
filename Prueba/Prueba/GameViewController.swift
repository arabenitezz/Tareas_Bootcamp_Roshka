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


        @IBOutlet weak var userLabel: UILabel!
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
            userLabel.text = UserDefaults.standard.string(forKey: "currentUser")
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
            moveBall()
            
            timerConnector?.cancel()
            timerConnector = Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink{ [weak self] currentDate in
                    guard let self = self, let endDate = self.endDate else { return }

                    
                    let remaining = endDate.timeIntervalSince(currentDate)
                    if remaining > 0 {
                        self.timeRemaining = remaining
                        self.timerLabel.text = "\(Int(remaining))"
                    } else {
                        // funcion para terminar el juego
                        endGame()
                    }
                    
                }
 
        }
    
    @IBAction func ballTapped(_ sender: UIButton) {
        score += 1
        scoreLabel.text = "Puntaje: \(score)"
        // funcion para mover la pelota
        moveBall()
    }
    
    private func moveBall() {
        let maxX = gameContainer.bounds.width - ballButton.frame.width
        let maxY = gameContainer.bounds.height - ballButton.frame.height
        
        let randomX = CGFloat.random(in: 0...maxX)
        let randomY = CGFloat.random(in: 0...maxY)
        
        UIView.animate(withDuration: 0.2) {
            self.ballButton.frame.origin = CGPoint(x: randomX, y: randomY)
        }
    }
    
    private func saveScore() {
        let defaults = UserDefaults.standard
        var leaderboard = defaults.dictionary(forKey: "leaderboard") as? [String: Int] ?? [:]
        
        let username = UserDefaults.standard.string(forKey: "currentUser") ?? "Jugador"
        
        leaderboard[username] = max(score, leaderboard[username] ?? 0)
        
        let sortedLeaderboard = leaderboard.sorted { $0.value > $1.value }.prefix(5)
        let top5: [String: Int] = Dictionary(uniqueKeysWithValues: sortedLeaderboard.map { ($0.key, $0.value) })

        
        defaults.set(top5, forKey: "leaderboard")
        defaults.synchronize()
        
    }
    
    private func endGame() {
        timerConnector?.cancel()
        timerLabel.text = "0"
        ballButton.isHidden = true
        
        saveScore()
        
        let alert = UIAlertController(title: "Juego terminado", message: "Puntaje final \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)

    }
}

