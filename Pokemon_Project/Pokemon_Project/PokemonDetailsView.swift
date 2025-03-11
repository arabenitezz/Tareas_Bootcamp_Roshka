import UIKit
import Kingfisher

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        if let imageUrl = URL(string: pokemon.sprites.other.officialArtwork.frontDefault) {
            pokemonImageView.kf.setImage(with: imageUrl)
        }
    }
}
