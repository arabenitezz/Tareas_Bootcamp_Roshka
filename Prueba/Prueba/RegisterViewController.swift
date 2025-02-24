//
//  RegisterViewController.swift
//  Prueba
//
//  Created by Bootcamp on 2/24/25.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var RegisterTitleTextLabel: UILabel!
    
    @IBOutlet weak var RegisterNameTextField: UITextField!
    
    @IBOutlet weak var RegisterLastNameTextField: UITextField!
    
    @IBOutlet weak var RegisterEmailTextField: UITextField!
    
    @IBOutlet weak var ReggisterDateTextField: UITextField!
    
    @IBOutlet weak var RegisterPasswordTextField: UITextField!
    
    @IBOutlet weak var RegisterRepeatPasswordTextField: UITextField!
    
    @IBOutlet weak var RegisterCreateAccountButton: UIButton!
    
    @IBOutlet weak var RegisterAlreadyHaveAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Acción para el botón "Registrarse"
        @IBAction func goToLogin(_ sender: UIButton) {
                performSegue(withIdentifier: "goToLogin", sender: self)
            }    }
    

}
