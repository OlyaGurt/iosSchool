import Foundation

protocol RegistrationAssembly {
    func registrationCoordinator(onRegistrationSuccess: (() -> Void)?) -> RegistrationCoordinator
    func registrationVC(onRegistrationSuccess: (() -> Void)?) -> RegistrationViewController<RegistrationViewImp>
    func registrationDataProvider() -> RegistrationDataProdiver
}

extension Assembly: RegistrationAssembly {
    func registrationCoordinator(onRegistrationSuccess: (() -> Void)?) -> RegistrationCoordinator {
        RegistrationCoordinator(assembly: self, context: .init(onRegistrationSuccess: onRegistrationSuccess))
    }

    func registrationVC(onRegistrationSuccess: (() -> Void)?) -> RegistrationViewController<RegistrationViewImp> {
        .init(
            onRegistrationSuccess: onRegistrationSuccess,
            dataProvider: registrationDataProvider(),
            storageManager: storageManager
        )}

    func registrationDataProvider() -> RegistrationDataProdiver {
        RegistrationDataProviderImp(apiClient: apiClient)
    }
}
