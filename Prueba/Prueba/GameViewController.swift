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
        private var timerConnector: AnyCancellable?
        private var timeRemaining: TimeInterval = 30
        private var endDate: Date?

        override func viewDidLoad() {
            super.viewDidLoad()
            timerLabel.text = "30"
        }

        @IBAction func startTimerButtonTapped(_ sender: UIButton) {
            startTimer()
        }

        private func startTimer() {
            timeRemaining = 30
            endDate = Date().addingTimeInterval(timeRemaining)

            timerConnector?.cancel() // Asegura que no haya timers previos corriendo
            timerConnector = Timer.publish(every: 1.0, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] currentDate in
                    guard let self, let endDate else { return }

                    let remaining = endDate.timeIntervalSince(currentDate)
                    if remaining > 0 {
                        self.timeRemaining = remaining
                        self.timerLabel.text = "\(Int(remaining))"
                    } else {
                        self.timerConnector?.cancel()
                        self.timerLabel.text = "0"
                    }
                }
        }
    }

