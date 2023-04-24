import UIKit

class FieldCell: UITableViewCell {

    @IBOutlet private weak var backgroundFieldView: UIView!
    @IBOutlet private weak var fieldLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!

    func makeField() {
        backgroundFieldView.layer.cornerRadius = 15
        backgroundFieldView.layer.borderColor = UIColor(named: "GreyForBorder")?.cgColor
        backgroundFieldView.layer.borderWidth = 1
    }

    func makeLabel(textLabel: String, date: String) {
        fieldLabel.text = textLabel
        dateLabel.text = date
    }

    func makeColorView(color: UIColor) {
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = color
    }
}
