import UIKit
import SPIndicator

class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {

    private let dataProvider: RegistrationDataProdiver

    init(dataProvider: RegistrationDataProdiver) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.update(with: RegistrationViewData())
        rootView.delegate = self
    }
}

// MARK: - RegistrationViewDelegate

extension RegistrationViewController: RegistrationViewDelegate {
    func registrationButtonDidTap(login: String, password: String, repeatPassword: String) {
        guard password == repeatPassword else {
            return
        }
        dataProvider.registration(username: login, password: password) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    SPIndicator.present(title: "Успешная регистрация", preset: .done, haptic: .success)
                    self?.dismiss(animated: true)
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    SPIndicator.present(
                        title: "Ошибка регистрации: \(failure.rawValue)",
                        preset: .error,
                        haptic: .error
                    )}
            }
        }
    }

    func backButtonDidTap() {
        self.dismiss(animated: true)
    }
}
