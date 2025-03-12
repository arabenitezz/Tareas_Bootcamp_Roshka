import UIKit
import Kingfisher

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = pokemon.name.capitalized
    
        let types = pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", ")
        typeLabel.text = "Tipo: \(types)"
        
        let weight = Double(pokemon.weight) / 10.0
        weightLabel.text = "Peso: \(weight) kg"
        
        let height = Double(pokemon.height) / 10.0
        heightLabel.text = "Altura: \(height) m"
        
        
        if let imageUrl = URL(string: pokemon.sprites.other.officialArtwork.frontDefault) {
            pokemonImageView.kf.setImage(with: imageUrl)
        }
    }
}
