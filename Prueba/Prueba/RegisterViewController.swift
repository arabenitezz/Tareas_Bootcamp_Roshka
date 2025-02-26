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
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = UIColor(red: 248/255, green: 251/255, blue: 255/255, alpha: 1.0)
    }

    @IBAction func goToLogin(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
        @IBAction func createAccount(_ sender: UIButton) {
            guard let email = RegisterEmailTextField.text, !email.isEmpty,
                  let password = RegisterPasswordTextField.text, !password.isEmpty,
                  let repeatPassword = RegisterRepeatPasswordTextField.text, !repeatPassword.isEmpty else {
                showAlert(message: "Todos los campos son obligatorios.")
                return
            }

            if password != repeatPassword {
                showAlert(message: "Las contraseñas no coinciden.")
                return
            }

            var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]

            
            if users[email] != nil {
                showAlert(message: "El usuario ya está registrado.")
                return
            }

            users[email] = password
            UserDefaults.standard.setValue(users, forKey: "users")

            showAlert(message: "Usuario registrado con éxito. Ahora puedes iniciar sesión.") {
                self.dismiss(animated: true)
            }
            print(users)
        }

        func showAlert(message: String, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: "Registro", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            })
            present(alert, animated: true)
        
        }
    


    }

