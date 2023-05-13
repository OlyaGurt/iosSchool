import Foundation
import UIKit

protocol AuthView: UIView {
    var registrationAction: (() -> Void)? { get set }
    var delegate: AuthViewDelegate? { get set }

    func update(with data: AuthViewData)
}

protocol AuthViewDelegate: AnyObject {
    func loginButtonDidTap(login: String, password: String)
}

class AuthViewImp: UIView, AuthView {
    var registrationAction: (() -> Void)?

    weak var delegate: AuthViewDelegate?

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var helloView: UIView!
    @IBOutlet private weak var helloLabel: UILabel!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: CustomButton!
    @IBOutlet private var registrationButton: CustomButton!
    @IBOutlet private weak var passwordEyeButton: UIButton!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func update(with data: AuthViewData) {

        let recognize = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        addGestureRecognizer(recognize)
        scrollView.keyboardDismissMode = .onDrag

        helloLabel.text = data.loginTextFieldPlaceholder
        helloView.layer.shadowColor = UIColor.black.cgColor
        helloView.layer.shadowOpacity = 0.25
        helloView.layer.shadowOffset = CGSize(width: 0, height: 8)
        helloView.layer.shadowRadius = 10

        loginTextField.placeholder = data.enterLoginTextFielsPlaceholder
        loginTextField.backgroundColor = .white.withAlphaComponent(0.6)
        loginTextField.layer.cornerRadius = 15
        loginTextField.layer.masksToBounds = true
        loginTextField.delegate = self
        loginTextField.setLeftPaddingPoints(5)
        loginTextField.setRightPaddingPoints(5)

        passwordTextField.placeholder = data.enterPasswordTextFielsPlaceholder
        passwordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true
        passwordTextField.delegate = self
        passwordTextField.setLeftPaddingPoints(5)
        passwordTextField.setRightPaddingPoints(40)

        makeButton(button: loginButton)
        makeButton(button: registrationButton)

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

    @IBAction func loginButtonDidTap(sender: UIButton) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        delegate?.loginButtonDidTap(
            login: loginTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }

    @IBAction func passwordEyeButtonAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if passwordTextField.isSecureTextEntry {
            passwordEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }

    @objc
    private func closeKeyboard() {
        endEditing(true)
    }

    @IBAction func registrationButtonDidTap(sender: UIButton) {
        registrationAction?()
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

// MARK: - UITextFieldDelegate

extension AuthViewImp: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
