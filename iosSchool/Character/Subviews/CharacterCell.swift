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

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: "NewLilac50")
        layer.cornerRadius = 15
    }

    private func update(_ viewModel: CharacterCellData?) {
        guard let viewModel else {
            return
        }
        imageView.image = viewModel.isLoading ? UIImage(named: "character1") : viewModel.image
        nameLabel.text = viewModel.name
        typeLabel.text = (viewModel.gender ?? "") + " " + (viewModel.type ?? "")
    }
}
