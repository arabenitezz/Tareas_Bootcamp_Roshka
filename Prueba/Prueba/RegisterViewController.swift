import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var RegisterTitleTextLabel: UILabel!
    @IBOutlet weak var RegisterUsernameTextField: UITextField!
    @IBOutlet weak var RegisterEmailTextField: UITextField!
    @IBOutlet weak var RegisterPasswordTextField: UITextField!
    @IBOutlet weak var RegisterRepeatPasswordTextField: UITextField!
    @IBOutlet weak var RegisterCreateAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        self.navigationItem.setHidesBackButton(false, animated: false)
        
    }

    
    @IBAction func createAccount(_ sender: UIButton) {
        guard let username = RegisterUsernameTextField.text, !username.isEmpty,
              let email = RegisterEmailTextField.text, !email.isEmpty,
              let password = RegisterPasswordTextField.text, !password.isEmpty,
              let repeatPassword = RegisterRepeatPasswordTextField.text, !repeatPassword.isEmpty else {
            showAlert(message: "Todos los campos son obligatorios.")
            return
        }

        // validar que las contraseñas coincidan
        if password != repeatPassword {
            showAlert(message: "Las contraseñas no coinciden.")
            return
        }
        
        // validar formato de correo electrónico
        if !isValidEmail(email) {
            showAlert(message: "El formato del correo electrónico no es válido.")
            return
        }

        // obtener usuarios existentes
        var usersDict = UserDefaults.standard.dictionary(forKey: "usersData") as? [String: [String: Any]] ?? [:]
        
        // verificar si el correo ya está registrado
        if usersDict[email] != nil {
            showAlert(message: "Este correo electrónico ya está registrado.")
            return
        }
        
        // verificar si el nombre de usuario ya esta registrado
        for (_, userData) in usersDict {
            if let existingUsername = userData["username"] as? String, existingUsername == username {
                showAlert(message: "Este nombre de usuario ya está en uso.")
                return
            }
        }
        
        // guardar todos los datos del usuario
        let userData: [String: Any] = [
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
    
    // funcion para validar formato de correo electronico
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    //alertas

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Registro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}

