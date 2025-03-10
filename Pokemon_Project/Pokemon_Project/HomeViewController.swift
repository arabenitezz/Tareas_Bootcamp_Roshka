import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSimpleSearch" {
            // Configurar la vista de búsqueda simple si es necesario
        } else if segue.identifier == "goToTypeSearch" {
            // Configurar la vista de búsqueda por tipo si es necesario
        }
    }
}
