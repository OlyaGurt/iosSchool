import Foundation
import UIKit

struct CoordinatorContext {}

class AppCoordinator: BaseCoordinator<CoordinatorContext> {
    private var window: UIWindow?

    func start(window: UIWindow) {
        self.window = window
        let coordinator = assembly.splashCoordinator { [weak self] in
            self?.startCharacter()
        }
        setRoot(viewController: coordinator.make())
    }

    private func startAuth() {
        let coordinator = assembly.authCoordinator()
        setRoot(viewController: coordinator.make())
    }

    private func startRegistration() {
        let coordinator = assembly.registrationCoordinator()
        setRoot(viewController: coordinator.make())
    }

    private func startLocation() {
        let coordinator = assembly.locationCoordinator()
        setRoot(viewController: coordinator.make())
    }

    private func startCharacter() {
        let coordinator = assembly.characterCoordinator()
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
