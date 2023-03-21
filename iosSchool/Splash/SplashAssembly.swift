import Foundation

protocol SplashAssembly {
    func splashCoordinator() -> SplashCoordinator
    func splashVC() -> SlashViewController
    func splashDataProvider() -> SplashDataProvider
}

extension Assembly: SplashAssembly {

    func splashCoordinator() -> SplashCoordinator {
        SplashCoordinator(assembly: self, context: .init())

    }
    func splashVC() -> SlashViewController {
        .init(dataProvider: splashDataProvider())
    }

    func splashDataProvider() -> SplashDataProvider {
        SplashDataProviderImp()
    }
}
