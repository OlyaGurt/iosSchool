import Foundation

protocol AuthAssembly {
    func authCoordinator() -> AuthCoordinator
    func authVC() -> AuthViewController
    func authDataProvider() -> AuthDataProvider
}

extension Assembly: AuthAssembly {
    func authCoordinator() -> AuthCoordinator {
        AuthCoordinator(assembly: self, context: .init())
    }
    func authVC() -> AuthViewController {
        .init(dataProvider: authDataProvider())
    }

    func authDataProvider() -> AuthDataProvider {
        AuthDataProviderImp(apiClient: apiClient)
    }
}
