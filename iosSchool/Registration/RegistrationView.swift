import Foundation
import UIKit

protocol RegistrationView: UIView {
    func update(with data: RegistrationViewData)
}

class RegistrationViewImp: UIView, RegistrationView {
    func update(with data: RegistrationViewData) {
    }
}
