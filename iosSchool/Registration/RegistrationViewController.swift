import UIKit
import SPIndicator
import PKHUD

class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {

    var onRegistrationSuccess: (() -> Void)?

    private let dataProvider: RegistrationDataProdiver
    private let storageManager: StorageManager

    init(onRegistrationSuccess: (() -> Void)?, dataProvider: RegistrationDataProdiver, storageManager: StorageManager) {
        self.onRegistrationSuccess = onRegistrationSuccess
        self.dataProvider = dataProvider
        self.storageManager = storageManager
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
            SPIndicator.present(
                title: "Пароли не совпадают",
                preset: .error,
                haptic: .error
            )
            return
        }
        HUD.show(.progress)
        dataProvider.registration(username: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                HUD.hide()
            }
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    self?.storageManager.saveToken(token: token)
                    self?.storageManager.saveUsername(cabinet: Cabinet(username: login))
                    self?.onRegistrationSuccess?()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    SPIndicator.present(
                        title: "Ошибка регистрации: \(failure.rawValue)",
                        preset: .error,
                        haptic: .error
                    )
                }
            }
        }
    }

    func backButtonDidTap() {
        self.dismiss(animated: true)
    }
}
