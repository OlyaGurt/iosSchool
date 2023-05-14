import Foundation
import UIKit

struct FieldCellData {
    let textLabel: String
    let date: String?
    let color: UIColor?
    let colorIsHidden: Bool

    init(date: String?, color: UIColor?, colorIsHidden: Bool) {
        self.textLabel = colorIsHidden ? "Дата регистрации" : "Цвет профиля"
        self.date = date
        self.color = color
        self.colorIsHidden = colorIsHidden
    }
}
