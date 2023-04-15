import Foundation

protocol SplashAssembly {
    func splashCoordinator(onSuccess: (() -> Void)?) -> SplashCoordinator
    func splashVC(onSuccess: (() -> Void)?) -> SplashViewController<SplashViewImp>
    func splashDataProvider() -> SplashDataProvider
}

extension Assembly: SplashAssembly {

    func splashCoordinator(onSuccess: (() -> Void)?) -> SplashCoordinator {
        SplashCoordinator(assembly: self, context: .init(onSuccess: onSuccess))

    }
    func splashVC(onSuccess: (() -> Void)?) -> SplashViewController<SplashViewImp> {
        .init(dataProvider: splashDataProvider(), onSuccess: onSuccess)
    }

    func splashDataProvider() -> SplashDataProvider {
        SplashDataProviderImp()
    }
}
