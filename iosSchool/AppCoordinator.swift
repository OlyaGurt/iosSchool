import Foundation
import UIKit

struct CoordinatorContext {}

class AppCoordinator: BaseCoordinator<CoordinatorContext> {
    private var window: UIWindow?

    func start(window: UIWindow) {
        self.window = window
        let coordinator = assembly.splashCoordinator()
        setRoot(viewController: coordinator.make())
    }

    private func setRoot(viewController: UIViewController?) {
        guard let window, let viewController else {
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
