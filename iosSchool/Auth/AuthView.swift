import Foundation
import UIKit

protocol AuthView: UIView {
    var registrationAction: (() -> Void)? { get set }

    func update(with data: AuthViewData)
}

class AuthViewImp: UIView, AuthView {
    var registrationAction: (() -> Void)?

    @IBOutlet private weak var helloView: UIView!
    @IBOutlet private weak var helloLabel: UILabel!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: CustomButton!
    @IBOutlet private var registrationButton: CustomButton!

    func update(with data: AuthViewData) {
        helloLabel.text = data.loginTextFieldPlaceholder
        helloView.layer.shadowColor = UIColor.black.cgColor
        helloView.layer.shadowOpacity = 0.25
        helloView.layer.shadowOffset = CGSize(width: 0, height: 8)
        helloView.layer.shadowRadius = 10

        loginTextField.backgroundColor = .white.withAlphaComponent(0.6)
        loginTextField.layer.cornerRadius = 15
        loginTextField.layer.masksToBounds = true

        passwordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true

        makeButton(button: loginButton)
        makeButton(button: registrationButton)
    }

    // MARK: - Actions

    @IBAction func loginButtonDidTap(sender: UIButton) {
        
    }

    @IBAction func registrationButtonDidTap(sender: UIButton) {
        registrationAction?()
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
