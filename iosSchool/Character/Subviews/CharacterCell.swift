import UIKit

class CharacterCell: UICollectionViewCell {

    var viewModel: CharacterCellData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var blurView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: "NewLilac50")
        layer.cornerRadius = 15
    }

    private func update(_ viewModel: CharacterCellData?) {
        guard let viewModel else {
            return
        }
        blurView.isHidden = !viewModel.isLoading
        if viewModel.isLoading {
            activityIndicator.startAnimating()
            imageView.image = UIImage(named: "character1")
            activityIndicator.isHidden = false
            nameLabel.isHidden = true
            typeLabel.isHidden = true
        } else {
            imageView.image = viewModel.image
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            nameLabel.isHidden = false
            typeLabel.isHidden = false
            nameLabel.text = viewModel.name
            typeLabel.text = (viewModel.gender ?? "") + " " + (viewModel.type ?? "")
        }
    }
}
