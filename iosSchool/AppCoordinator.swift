import Foundation
import UIKit

struct CoordinatorContext {}

class AppCoordinator: BaseCoordinator<CoordinatorContext> {
    private var window: UIWindow?

    func start(window: UIWindow) {
        self.window = window
        let coordinator = assembly.splashCoordinator { [weak self] in
            self?.startAuth()
        }
        setRoot(viewController: coordinator.make())
    }

    private func startAuth() {
        guard assembly.storageManager.getToken() == nil else {
            setTapVC()
            return
        }
        let coordinator = assembly.authCoordinator { [ weak self] in
            DispatchQueue.main.async {
                self?.setTapVC()
            }
        }
        setRoot(viewController: coordinator.make())
    }

    private func setTapVC() {
        let tabVC = assembly.rootTabBarController()
        let locationCoordinator = assembly.locationCoordinator()
        let cabinerCoordinator = assembly.cabinetCoodrinator {
            self.startAuth()
        }

        let locationVC = locationCoordinator.make()
        let cabinetVC = cabinerCoordinator.make()

        let navVC = assembly.rootNavigationController()
        navVC.setViewControllers([locationVC], animated: false)
        navVC.tabBarItem = RootTab.locations.tabBarItem

        cabinetVC.tabBarItem = RootTab.cabinet.tabBarItem
        tabVC.setViewControllers([navVC, cabinetVC], animated: false)
        setRoot(viewController: tabVC)
    }

    private func setRoot(viewController: UIViewController?) {
        guard let window, let viewController else {
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
