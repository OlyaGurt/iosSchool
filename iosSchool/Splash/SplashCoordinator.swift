import Foundation
import UIKit

class SplashCoordinator: BaseCoordinator<SplashCoordinator.Context> {
    struct Context {
        let onSuccess: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.splashVC(onSuccess: context.onSuccess)
        return controller
    }
}
