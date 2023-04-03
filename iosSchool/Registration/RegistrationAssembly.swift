import Foundation

protocol RegistrationAssembly {
    func registrationCoordinator() -> RegistrationCoordinator
    func registrationVC() -> RegistrationViewController<RegistrationViewImp>
    func registrationDataProvider() -> RegistrationDataProdiver
}

extension Assembly: RegistrationAssembly {
    func registrationCoordinator() -> RegistrationCoordinator {
        RegistrationCoordinator(assembly: self, context: .init())
    }

    func registrationVC() -> RegistrationViewController<RegistrationViewImp> {
        .init(dataProvider: registrationDataProvider())
    }

    func registrationDataProvider() -> RegistrationDataProdiver {
        RegistrationDataProviderImp(apiClient: apiClient)
    }
}
