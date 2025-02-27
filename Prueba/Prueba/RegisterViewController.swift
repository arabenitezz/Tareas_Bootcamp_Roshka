import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var RegisterTitleTextLabel: UILabel!
    @IBOutlet weak var RegisterNameTextField: UITextField!
    @IBOutlet weak var RegisterUsernameTextField: UITextField!
    @IBOutlet weak var RegisterEmailTextField: UITextField!
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
        guard let name = RegisterNameTextField.text, !name.isEmpty,
              let username = RegisterUsernameTextField.text, !username.isEmpty,
              let email = RegisterEmailTextField.text, !email.isEmpty,
              let password = RegisterPasswordTextField.text, !password.isEmpty,
              let repeatPassword = RegisterRepeatPasswordTextField.text, !repeatPassword.isEmpty else {
            showAlert(message: "Todos los campos son obligatorios.")
            return
        }

        // Validar que las contraseñas coincidan
        if password != repeatPassword {
            showAlert(message: "Las contraseñas no coinciden.")
            return
        }
        
        // Validar formato de correo electrónico
        if !isValidEmail(email) {
            showAlert(message: "El formato del correo electrónico no es válido.")
            return
        }

        // Obtener usuarios existentes
        var usersDict = UserDefaults.standard.dictionary(forKey: "usersData") as? [String: [String: Any]] ?? [:]
        
        // Verificar si el correo ya está registrado
        if usersDict[email] != nil {
            showAlert(message: "Este correo electrónico ya está registrado.")
            return
        }
        
        // Verificar si el nombre de usuario ya está registrado
        for (_, userData) in usersDict {
            if let existingUsername = userData["username"] as? String, existingUsername == username {
                showAlert(message: "Este nombre de usuario ya está en uso.")
                return
            }
        }
        
        // Guardar todos los datos del usuario
        let userData: [String: Any] = [
            "name": name,
            "username": username,
            "email": email,
            "password": password
        ]
        
        usersDict[email] = userData
        UserDefaults.standard.setValue(usersDict, forKey: "usersData")

        showAlert(message: "Usuario registrado con éxito. Ahora puedes iniciar sesión.") {
            self.dismiss(animated: true)
        }
        print("Usuario registrado: \(userData)")
    }
    
    // Función para validar formato de correo electrónico
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Registro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}

