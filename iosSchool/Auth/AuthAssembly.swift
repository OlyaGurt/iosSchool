import Foundation

protocol AuthAssembly {
    func authCoordinator(onLoginSuccess: (() -> Void)?) -> AuthCoordinator
    func authVC(onLoginSuccess: (() -> Void)?) -> AuthViewController<AuthViewImp>
    func authDataProvider() -> AuthDataProvider
    func cabinetDataProvider() -> CabinetDataProvider
}

extension Assembly: AuthAssembly {
    func authCoordinator(onLoginSuccess: (() -> Void)?) -> AuthCoordinator {
        AuthCoordinator(assembly: self, context: .init(onLoginSuccess: onLoginSuccess))
    }
    func authVC(onLoginSuccess: (() -> Void)?) -> AuthViewController<AuthViewImp> {
        .init(
            authDataProvider: authDataProvider(),
            cabinetDataProvider: cabinetDataProvider(),
            storageManager: storageManager,
            onLoginSuccess: onLoginSuccess
        )}

    func authDataProvider() -> AuthDataProvider {
        AuthDataProviderImp(apiClient: apiClient)
    }

    func cabinetDataProvider() -> CabinetDataProvider {
        CabinetDataProviderImp(apiClient: apiClient)
    }
}
