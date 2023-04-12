import Foundation
import UIKit

protocol RegistrationView: UIView {
    var backAction: (() -> Void)? { get set }

    func update(with data: RegistrationViewData)
}

class RegistrationViewImp: UIView, RegistrationView {
    var backAction: (() -> Void)?
    var registrationAction: (() -> Void)?

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var registrationLabel: UILabel!
    @IBOutlet private weak var loginView: UIStackView!
    @IBOutlet private weak var enterLoginTextField: UITextField!
    @IBOutlet private weak var enterPasswordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!
    @IBOutlet private weak var doneButton: CustomButton!
    @IBOutlet private weak var backButton: CustomButton!

    func update(with data: RegistrationViewData) {
        imageView.contentMode = .scaleToFill
        registrationLabel.text = data.registrationTextFieldPlaceholder

        enterLoginTextField.placeholder = data.enterLoginTextFielsPlaceholder
        enterLoginTextField.textColor = .lightGray
        enterLoginTextField.backgroundColor = .white.withAlphaComponent(0.6)
        enterLoginTextField.layer.cornerRadius = 15
        enterLoginTextField.layer.masksToBounds = true

        enterPasswordTextField.placeholder = data.enterPasswordTextFielsPlaceholder
        enterPasswordTextField.textColor = .lightGray
        enterPasswordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        enterPasswordTextField.layer.cornerRadius = 15
        enterPasswordTextField.layer.masksToBounds = true

        repeatPasswordTextField.placeholder = data.repeatPasswordTextFielsPlaceholder
        repeatPasswordTextField.textColor = .lightGray
        repeatPasswordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        repeatPasswordTextField.layer.cornerRadius = 15
        repeatPasswordTextField.layer.masksToBounds = true

        makeButton(button: doneButton)
        makeButton(button: backButton)
    }

    // MARK: - Actions

    @IBAction func doneButtonDidTap(_ sender: UIButton) {
    }

    @IBAction func backButtonDidTap(_ sender: UIButton) {
        backAction?()
    }

    // MARK: - Private methods

    private func makeButton(button: CustomButton) {
        button.normalColor = UIColor(named: "VelvetBlue") ?? .white
        button.highlightColor = .white
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.22).cgColor
        button.layer.borderWidth = 1
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
    }
}
