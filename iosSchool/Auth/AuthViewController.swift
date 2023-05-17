import UIKit
import SPIndicator
import PKHUD

class AuthViewController<View: AuthView>: BaseViewController<View> {

    var onLoginSuccess: (() -> Void)?
    var onOpenRegistration: (() -> Void)?

    private let authDataProvider: AuthDataProvider
    private let cabinetDataProvider: CabinetDataProvider
    private let storageManager: StorageManager

    init(
        authDataProvider: AuthDataProvider,
        cabinetDataProvider: CabinetDataProvider,
        storageManager: StorageManager,
        onLoginSuccess: (() -> Void)?
    ) {
        self.authDataProvider = authDataProvider
        self.cabinetDataProvider = cabinetDataProvider
        self.onLoginSuccess = onLoginSuccess
        self.storageManager = storageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.update(with: AuthViewData())
        rootView.registrationAction = onOpenRegistration
        rootView.delegate = self
    }
}

// MARK: - AuthViewDelegate

extension AuthViewController: AuthViewDelegate {
    func loginButtonDidTap(login: String, password: String) {
        HUD.show(.progress)
        authDataProvider.authorization(username: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                HUD.hide()
            }
            switch result {
            case .success(let token):
                self?.storageManager.saveToken(token: token)
                self?.cabinetDataProvider.getCabinet(cabinetId: login) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let cabinet):
                            self?.storageManager.saveUsername(cabinet: cabinet)
                        case .failure:
                            self?.storageManager.saveUsername(cabinet: Cabinet(username: "Логин пользователя"))
                        }
                        self?.onLoginSuccess?()
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    SPIndicator.present(title: "Ошибка авторизации", preset: .error, haptic: .error)
                }
            }
        }
    }
}
