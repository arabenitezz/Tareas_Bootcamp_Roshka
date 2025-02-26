//
//  HomeViewController.swift
//  Prueba
//
//  Created by Bootcamp on 2/25/25.
//

import UIKit

class HomeViewController: UIViewController {


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToGame(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGameSegue", sender: self)
      }

}
