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

        view.backgroundColor = UIColor(red: 248/255, green: 251/255, blue: 255/255, alpha: 1.0)

        LoginTitleFieldText.font = UIFont.boldSystemFont(ofSize: 32)
        LoginTitleFieldText.textColor = UIColor(red: 133/255, green: 193/255, blue: 233/255, alpha: 1.0)

        LoginForgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)

        // desabilitar login al inicio
        
        LoginButton.isEnabled = false

        // detectar cambios en los textfields
        LoginUserNameTextField.addTarget(self, action: #selector(verificarCampos), for: .editingChanged)
        LoginPasswordTextField.addTarget(self, action: #selector(verificarCampos), for: .editingChanged)
    }

    // veriifcar q los campos no esten vacios
    @objc func verificarCampos() {
        let usuario = LoginUserNameTextField.text ?? ""
        let contraseña = LoginPasswordTextField.text ?? ""
        LoginButton.isEnabled = !usuario.isEmpty && !contraseña.isEmpty
    }


    @IBAction func iniciarSesion(_ sender: UIButton) {
        guard let email = LoginUserNameTextField.text, !email.isEmpty,
              let password = LoginPasswordTextField.text, !password.isEmpty else {
            showAlert(message: "Todos los campos son obligatorios.")
            return
        }


        let users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]


        if let storedPassword = users[email], storedPassword == password {
            UserDefaults.standard.set(email, forKey: "currentUser")
            performSegue(withIdentifier: "goToHomeSegue", sender: self)
        } else {
            showAlert(message: "Correo o contraseña incorrectos.")
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



