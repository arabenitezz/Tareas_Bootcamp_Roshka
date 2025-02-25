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
    
    @IBAction func goToLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }


}
