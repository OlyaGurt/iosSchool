import Foundation
import UIKit

protocol RegistrationView: UIView {
    func update(with data: RegistrationViewData)
}

class RegistrationViewImp: UIView, RegistrationView {
    var registrationAction: (() -> Void)?
    func update(with data: RegistrationViewData) {
    }
}
