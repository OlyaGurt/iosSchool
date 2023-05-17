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
        activityIndicator.isHidden = !viewModel.isLoading
        nameLabel.isHidden = viewModel.isLoading
        typeLabel.isHidden = viewModel.isLoading

        if viewModel.isLoading {
            activityIndicator.startAnimating()
            imageView.image = UIImage(named: "character1")
        } else {
            imageView.image = viewModel.image
            activityIndicator.stopAnimating()
            nameLabel.text = viewModel.name
            typeLabel.text = (viewModel.gender ?? "") + " " + (viewModel.type ?? "")
        }
    }
}
