import Foundation
import UIKit

struct FieldCellData {
    let textLabel: String
    let date: String?
    let color: UIColor?
    let colorIsHidden: Bool

    init(textLabel: String, date: String?, color: UIColor?, colorIsHidden: Bool) {
        self.textLabel = textLabel
        self.date = date
        self.color = color
        self.colorIsHidden = colorIsHidden
    }
}
