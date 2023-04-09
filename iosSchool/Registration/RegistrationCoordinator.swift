import Foundation
import UIKit

class RegistrationCoordinator: BaseCoordinator<RegistrationCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.registrationVC()
        controller.onOpenAuth = { [weak controller] in
            let coordinator = self.assembly.authCoordinator()
            let authVC = coordinator.make()
            authVC.modalPresentationStyle = .fullScreen
            controller?.present(authVC, animated: true)
        }
        return controller
    }
}
