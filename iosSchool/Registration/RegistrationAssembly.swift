import Foundation

protocol RegistrationAssembly {
    func regCoordinator() -> RegistrationCoordinator
    func regVC() -> RegistrationViewController
    func regDataProvider() -> RegistrationDataProdiver
}

extension Assembly: RegistrationAssembly {
    func regCoordinator() -> RegistrationCoordinator {
        RegistrationCoordinator(assembly: self, context: .init())
    }

    func regVC() -> RegistrationViewController {
        .init(dataProvider: regDataProvider())
    }

    func regDataProvider() -> RegistrationDataProdiver {
        RegistrationDataProviderImp()
    }
}
