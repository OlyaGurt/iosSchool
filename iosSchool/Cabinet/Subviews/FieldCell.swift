import UIKit

class FieldCell: UITableViewCell {

    var viewModel: FieldCellData? {
        didSet {
            update(viewModel)
        }
    }
    @IBOutlet private weak var backgroundFieldView: UIView!
    @IBOutlet private weak var fieldLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 10
        backgroundFieldView.layer.cornerRadius = 15
        backgroundFieldView.layer.borderColor = UIColor(named: "GreyForBorder")?.cgColor
        backgroundFieldView.layer.borderWidth = 1
        colorView.layer.cornerRadius = 10
    }

    private func update(_ viewModel: FieldCellData?) {
        guard let viewModel else {
            return
        }
        fieldLabel.text = viewModel.textLabel
        if viewModel.colorIsHidden {
            colorView.isHidden = true
            dateLabel.text = viewModel.date
        } else {
            colorView.isHidden = false
            colorView.backgroundColor = viewModel.color
        }
    }
}
