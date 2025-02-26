import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var LeaderBoardTitleLabel: UILabel!
    @IBOutlet weak var LeaderboardListOfUsersLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadLeaderboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadLeaderboard()
    }
    
    private func loadLeaderboard() {
        let leaderboard = UserDefaults.standard.dictionary(forKey: "leaderboard") as? [String: Int] ?? [:]
        let sortedLeaderboard = leaderboard.sorted { $0.value > $1.value }
        
        LeaderBoardTitleLabel.text = "Top 5 puntajes"
        
        var leaderboardText = ""
        for (index, entry) in sortedLeaderboard.prefix(5).enumerated() {
            leaderboardText += "\(index + 1). \(entry.key): \(entry.value) puntos \n"
        }
        
        if leaderboardText.isEmpty {
            leaderboardText = "No hay puntajes registrados aun"
        }
        
        LeaderboardListOfUsersLabel.text = leaderboardText
        print(leaderboardText)
    }
    
    @IBAction func goToGame(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGameSegue", sender: self)
      }

}
