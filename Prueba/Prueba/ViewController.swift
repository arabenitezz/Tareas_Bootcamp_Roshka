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

        // Configurar estilos del título
        LoginTitleFieldText.font = UIFont.boldSystemFont(ofSize: 32)
        LoginTitleFieldText.textColor = UIColor(red: 133/255, green: 193/255, blue: 233/255, alpha: 1.0)

        // Reducir el tamaño del texto del botón "Olvidé mi contraseña"
        LoginForgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }

    // Acción para el botón "Registrarse"
    @IBAction func goToRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegisterSegue", sender: self)
    }
}


