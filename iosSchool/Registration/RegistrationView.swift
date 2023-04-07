import Foundation
import UIKit

protocol RegistrationView: UIView {
    func update(with data: RegistrationViewData)
}

class RegistrationViewImp: UIView, RegistrationView {
    var registrationAction: (() -> Void)?

    @IBOutlet private weak var registrationLabel: UILabel!
    @IBOutlet private weak var loginView: UIStackView!
    @IBOutlet private var enterLoginTextField: UITextField!
    @IBOutlet private var enterPasswordTextField: UITextField!
    @IBOutlet private var repeatPasswordTextField: UITextField!
    @IBOutlet private var doneButton: CustomButton!

    func update(with data: RegistrationViewData) {
        makeButton(button: doneButton)
    }

    // MARK: - Actions

    @IBAction func doneButtonDidTap(_ sender: UIButton) {
    }

    // MARK: - Private methods

    private func makeButton(button: CustomButton) {
        button.normalColor = UIColor(named: "VelvetBlue") ?? .white
        button.highlightColor = .white
        button.setTitleColor(.black, for: .highlighted)
    }
}
