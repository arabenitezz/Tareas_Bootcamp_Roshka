import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var LoginTitleFieldText: UILabel!
    @IBOutlet weak var LoginImage: UIImageView!
    @IBOutlet weak var LoginUserNameTextField: UITextField!
    @IBOutlet weak var LoginPasswordTextField: UITextField!
    @IBOutlet weak var LoginForgotPasswordButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var LoginRegisterButton: UIButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        self.navigationItem.setHidesBackButton(false, animated: false)

        // desabilitar login al inicio
        LoginButton.isEnabled = false

        // detectar cambios en los textfields
        LoginUserNameTextField.addTarget(self, action: #selector(verificarCampos), for: .editingChanged)
        LoginPasswordTextField.addTarget(self, action: #selector(verificarCampos), for: .editingChanged)
    }

    // verificar q los campos no esten vacios
    @objc func verificarCampos() {
        let usuario = LoginUserNameTextField.text ?? ""
        let contraseña = LoginPasswordTextField.text ?? ""
        LoginButton.isEnabled = !usuario.isEmpty && !contraseña.isEmpty
    }

    @IBAction func iniciarSesion(_ sender: UIButton) {
        guard let emailOrUsername = LoginUserNameTextField.text, !emailOrUsername.isEmpty,
              let password = LoginPasswordTextField.text, !password.isEmpty else {
            showAlert(message: "Todos los campos son obligatorios.")
            return
        }

        // Obtener todos los usuarios
        let usersDict = UserDefaults.standard.dictionary(forKey: "usersData") as? [String: [String: Any]] ?? [:]
        
        var userFound = false
        var userEmail = ""
        
        // Verificar si el texto introducido es un email o un nombre de usuario
        let isEmail = emailOrUsername.contains("@")
        
        if isEmail {
            // Si es un email, buscar directamente
            if let userData = usersDict[emailOrUsername],
               let storedPassword = userData["password"] as? String,
               storedPassword == password {
                userFound = true
                userEmail = emailOrUsername
            }
        } else {
            // Si es un nombre de usuario, buscar en todos los usuarios
            for (email, userData) in usersDict {
                if let username = userData["username"] as? String,
                   username == emailOrUsername,
                   let storedPassword = userData["password"] as? String,
                   storedPassword == password {
                    userFound = true
                    userEmail = email
                    break
                }
            }
        }
        
        if userFound {
            // Guardar el email del usuario actual para identificarlo en la aplicación
            UserDefaults.standard.set(userEmail, forKey: "currentUser")
            performSegue(withIdentifier: "goToHomeSegue", sender: self)
        } else {
            showAlert(message: "Usuario o contraseña incorrectos.")
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Inicio de Sesión", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegisterSegue", sender: self)
    }
}



