import Foundation

protocol RegAssembly {
    func regCoordinator() -> RegCoordinator
    func regVC() -> RegViewController
    func regDataProvider() -> RegDataProdiver
}

extension Assembly: RegAssembly {
    func regCoordinator() -> RegCoordinator {
        RegCoordinator(assembly: self, context: .init())
    }

    func regVC() -> RegViewController {
        .init(dataProvider: regDataProvider())
    }

    func regDataProvider() -> RegDataProdiver {
        RegDataProviderImp()
    }
}
