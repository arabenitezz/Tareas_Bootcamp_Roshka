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
        
        // userdefaults para el leaderboard
        let leaderboard = UserDefaults.standard.dictionary(forKey: "leaderboard") as? [String: Int] ?? [:]
        
        // nuevo array sorted
        
        let sortedLeaderboard = leaderboard.sorted { $0.value > $1.value }
        
        LeaderBoardTitleLabel.text = "Top 5 puntajes"
        
        // variable para la lista
        
        var leaderboardText = ""
        for (index, entry) in sortedLeaderboard.prefix(5).enumerated() {
            // Obtener el email del usuario
            let userEmail = entry.key
            
            // Buscar el nombre de usuario correspondiente al email
            let usersData = UserDefaults.standard.dictionary(forKey: "usersData") as? [String: [String: Any]] ?? [:]
            
            // Nombre de usuario por defecto (en caso de no encontrarlo)
            var displayName = userEmail
            
            // Si encontramos datos del usuario, usamos su nombre de usuario
            if let userData = usersData[userEmail], let username = userData["username"] as? String {
                displayName = username
            }
            
            leaderboardText += "\(index + 1). \(displayName): \(entry.value) puntos \n"
        }
        
        if leaderboardText.isEmpty {
            leaderboardText = "No hay puntajes registrados aun"
        }
        
        LeaderboardListOfUsersLabel.text = leaderboardText
    }
    
    @IBAction func goToGame(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGameSegue", sender: self)
    }
}
