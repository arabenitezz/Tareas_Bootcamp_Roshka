//
//  HomeViewController.swift
//  Prueba
//
//  Created by Bootcamp on 2/25/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var LeaderBoardTitleLabel: UILabel!
    @IBOutlet weak var LeaderboardListOfUsersLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToGame(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGameSegue", sender: self)
      }

}
