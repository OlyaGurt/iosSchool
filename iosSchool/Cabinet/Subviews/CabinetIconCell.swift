import UIKit

class CabinetIconCell: UITableViewCell {
    var viewModel: CabinetIconCellData? {
        didSet {
            update(viewModel)
        }
    }
    @IBOutlet private weak var backgroundCellView: UIImageView!
    @IBOutlet private weak var iconView: UIImageView!

    private func update(_ viewModel: CabinetIconCellData?) {
        guard let viewModel else {
            return
        }
        iconView.image = viewModel.image
    }
}
