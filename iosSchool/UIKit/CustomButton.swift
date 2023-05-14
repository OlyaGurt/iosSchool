import Foundation
import UIKit

class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            tintColor = isHighlighted ? .black : .white
            backgroundColor = isHighlighted ? highlightColor : normalColor
        }
    }

    @IBInspectable
    var highlightColor: UIColor = .white
    @IBInspectable
    var normalColor: UIColor = .white
}
