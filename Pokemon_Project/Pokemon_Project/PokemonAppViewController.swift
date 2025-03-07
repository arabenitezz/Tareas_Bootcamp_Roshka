import UIKit
import Kingfisher

class PokemonViewController: UIViewController {

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    private let pickerView = UIPickerView()
    private let categories = ["Nombre", "Número"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Crear un toolbar con un botón "Listo"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        // Asignar el toolbar como inputAccessoryView del TextField
        categoryTextField.inputAccessoryView = toolbar
        categoryTextField.inputView = pickerView
        categoryTextField.text = categories[0] // Valor por defecto
    }
    
    @objc private func dismissPicker() {
        view.endEditing(true) // Cierra el teclado o el picker
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let category = categoryTextField.text, let searchText = searchTextField.text, !searchText.isEmpty else { return }
        
        let endpoint = category == "Nombre" ?
            "https://pokeapi.co/api/v2/pokemon/\(searchText.lowercased())" :
            "https://pokeapi.co/api/v2/pokemon/\(searchText)"
        
        HTTPClient.request(
            endpoint: endpoint,
            method: .get,
            encoding: .json,
            headers: nil,
            onSuccess: { (pokemon: Pokemon) in
                DispatchQueue.main.async {
                    self.nameLabel.text = pokemon.name.capitalized
                    if let imageUrl = URL(string: pokemon.sprites.other.officialArtwork.frontDefault) {
                        self.pokemonImageView.kf.setImage(with: imageUrl)
                    }
                }
            },
            onFailure: { error in
                print("Error: \(error.message)")
            }
        )
    }
}

// extension
extension PokemonViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
        searchTextField.keyboardType = categories[row] == "Nombre" ? .alphabet : .numberPad
    }
}

