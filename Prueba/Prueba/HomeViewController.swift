//
//  HomeViewController.swift
//  Prueba
//
//  Created by Bootcamp on 2/25/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var HomeBackButton: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 248/255, green: 251/255, blue: 255/255, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }


}
