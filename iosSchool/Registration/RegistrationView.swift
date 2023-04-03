import Foundation
import UIKit

protocol RegistrationView: UIView {
}

class RegistrationViewImp: UIView, AuthView {
    var registrationAction: (() -> Void)?

    func update(with data: AuthViewData) {
    }
}
