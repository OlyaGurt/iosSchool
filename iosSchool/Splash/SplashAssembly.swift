import Foundation
import UIKit

protocol SplashAssembly {
    func splashCoordinator(onSuccess: (() -> Void)?) -> SplashCoordinator
    func splashVC(onSuccess: (() -> Void)?) -> SplashViewController<UIView>
    func splashDataProvider() -> SplashDataProvider
}

extension Assembly: SplashAssembly {

    func splashCoordinator(onSuccess: (() -> Void)?) -> SplashCoordinator {
        SplashCoordinator(assembly: self, context: .init(onSuccess: onSuccess))

    }
    func splashVC(onSuccess: (() -> Void)?) -> SplashViewController<UIView> {
        .init(dataProvider: splashDataProvider(), onSuccess: onSuccess)
    }

    func splashDataProvider() -> SplashDataProvider {
        SplashDataProviderImp()
    }
}
