import Foundation

protocol SplashAssembly {
    func splashCoordinator() -> SplashCoordinator
    func splashVC() -> SplashViewController
    func splashDataProvider() -> SplashDataProvider
}

extension Assembly: SplashAssembly {

    func splashCoordinator() -> SplashCoordinator {
        SplashCoordinator(assembly: self, context: .init())

    }
    func splashVC() -> SplashViewController {
        .init(dataProvider: splashDataProvider())
    }

    func splashDataProvider() -> SplashDataProvider {
        SplashDataProviderImp()
    }
}
