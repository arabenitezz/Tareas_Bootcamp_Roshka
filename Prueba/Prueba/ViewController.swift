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
        
        view.backgroundColor = UIColor(red: 248/255, green: 251/255, blue: 255/255, alpha: 1.0)

        // titulo disenho
        LoginTitleFieldText.font = UIFont.boldSystemFont(ofSize: 32)
        LoginTitleFieldText.textColor = UIColor(red: 133/255, green: 193/255, blue: 233/255, alpha: 1.0)

        // boton olvide mi contrasenha disenho
        LoginForgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)

        // deshabilitar el boton al inicio
        LoginButton.isEnabled = false

        // agg acciones a los textfields
        LoginUserNameTextField.addTarget(self, action: #selector(verificarCampos), for: .editingChanged)
        LoginPasswordTextField.addTarget(self, action: #selector(verificarCampos), for: .editingChanged)
    }

    // funcion para verificar si los campos estan vacios
    @objc func verificarCampos() {
        let usuario = LoginUserNameTextField.text ?? ""
        let contraseña = LoginPasswordTextField.text ?? ""

        // habilitamos el boton si los campos no estan vacios
        LoginButton.isEnabled = !usuario.isEmpty && !contraseña.isEmpty
    }

    // agg accion a iniciar sesion
    @IBAction func iniciarSesion(_ sender: UIButton) {
        if LoginButton.isEnabled {
            performSegue(withIdentifier: "goToHomeSegue", sender: self)
        }
    }

    // Acción para el botón "Registrarse"
    @IBAction func goToRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegisterSegue", sender: self)
    }
}



