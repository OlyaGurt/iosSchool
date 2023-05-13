import Foundation
import UIKit

protocol RegistrationView: UIView {
    var delegate: RegistrationViewDelegate? { get set }
    func update(with data: RegistrationViewData)
}

protocol RegistrationViewDelegate: AnyObject {
    func registrationButtonDidTap(login: String, password: String, repeatPassword: String)
    func backButtonDidTap()
}

class RegistrationViewImp: UIView, RegistrationView {
    var registrationAction: (() -> Void)?

    weak var delegate: RegistrationViewDelegate?

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var registrationLabel: UILabel!
    @IBOutlet private weak var loginView: UIStackView!
    @IBOutlet private weak var enterLoginTextField: UITextField!
    @IBOutlet private weak var enterPasswordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!
    @IBOutlet private weak var doneButton: CustomButton!
    @IBOutlet private weak var backButton: CustomButton!
    @IBOutlet private weak var passwordEyeButton: UIButton!
    @IBOutlet private weak var repeatPasswordEyeButton: UIButton!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func update(with data: RegistrationViewData) {
        imageView.contentMode = .scaleToFill
        let recognize = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        addGestureRecognizer(recognize)
        registrationLabel.text = data.registrationTextFieldPlaceholder

        enterLoginTextField.placeholder = data.enterLoginTextFielsPlaceholder
        enterLoginTextField.textColor = .lightGray
        enterLoginTextField.backgroundColor = .white.withAlphaComponent(0.6)
        enterLoginTextField.layer.cornerRadius = 15
        enterLoginTextField.layer.masksToBounds = true
        enterLoginTextField.delegate = self
        enterLoginTextField.setLeftPaddingPoints(5)
        enterLoginTextField.setRightPaddingPoints(5)

        enterPasswordTextField.placeholder = data.enterPasswordTextFielsPlaceholder
        enterPasswordTextField.textColor = .lightGray
        enterPasswordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        enterPasswordTextField.layer.cornerRadius = 15
        enterPasswordTextField.layer.masksToBounds = true
        enterPasswordTextField.delegate = self
        enterPasswordTextField.setLeftPaddingPoints(5)
        enterPasswordTextField.setRightPaddingPoints(40)

        repeatPasswordTextField.placeholder = data.repeatPasswordTextFielsPlaceholder
        repeatPasswordTextField.textColor = .lightGray
        repeatPasswordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        repeatPasswordTextField.layer.cornerRadius = 15
        repeatPasswordTextField.layer.masksToBounds = true
        repeatPasswordTextField.delegate = self
        repeatPasswordTextField.setLeftPaddingPoints(5)
        repeatPasswordTextField.setRightPaddingPoints(40)

        makeButton(button: doneButton)
        makeButton(button: backButton)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Actions

    @IBAction func doneButtonDidTap(_ sender: UIButton) {
        enterLoginTextField.resignFirstResponder()
        enterPasswordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()

        delegate?.registrationButtonDidTap(
            login: enterLoginTextField.text ?? "",
            password: enterPasswordTextField.text ?? "",
            repeatPassword: repeatPasswordTextField.text ?? ""
        )
    }

    @IBAction func backButtonDidTap(_ sender: UIButton) {
        enterLoginTextField.resignFirstResponder()
        enterPasswordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
        delegate?.backButtonDidTap()
    }

    @IBAction func passwordEyeButtonAction(_ sender: Any) {
        enterPasswordTextField.isSecureTextEntry = !enterPasswordTextField.isSecureTextEntry
        if enterPasswordTextField.isSecureTextEntry {
            passwordEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }

    @IBAction func repeatPasswordEyeButtonAction(_ sender: Any) {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
        if repeatPasswordTextField.isSecureTextEntry {
            repeatPasswordEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            repeatPasswordEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }

    @objc
    private func closeKeyboard() {
        endEditing(true)
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight + 15
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }

    @objc
    private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
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

extension RegistrationViewImp: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case enterLoginTextField:
            enterPasswordTextField.becomeFirstResponder()
        case enterPasswordTextField:
            repeatPasswordTextField.becomeFirstResponder()
        case repeatPasswordTextField:
            repeatPasswordTextField.resignFirstResponder()
        default:
            repeatPasswordTextField.resignFirstResponder()
        }
        return true
    }
}

