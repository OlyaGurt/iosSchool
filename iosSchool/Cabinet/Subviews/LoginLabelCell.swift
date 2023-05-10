import UIKit

class LoginLabelCell: UITableViewCell {

    var viewModel: LoginLabelCellData? {
        didSet {
            update(viewModel)
        }
    }
    @IBOutlet private weak var loginLabel: UILabel!

    private func update(_ viewModel: LoginLabelCellData?) {
        guard let viewModel else {
            return
        }
        loginLabel.text = viewModel.loginLabel
    }
}
