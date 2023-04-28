import UIKit

class CharacterCell: UICollectionViewCell {

    var viewModel: CharacterCellData? {
        didSet {
            update(viewModel)
            makeCell()
        }
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!

    private func update(_ viewModel: CharacterCellData?) {
        guard let viewModel else {
            return
        }
        imageView.image = viewModel.isLoading ? UIImage(named: "character1") : viewModel.image
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
    }

    private func makeCell() {
        self.backgroundColor = UIColor(named: "NewLilac50")
        self.layer.cornerRadius = 15
    }
}
