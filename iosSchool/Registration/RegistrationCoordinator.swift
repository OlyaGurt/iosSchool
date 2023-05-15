import Foundation
import UIKit

class RegistrationCoordinator: BaseCoordinator<RegistrationCoordinator.Context> {
    struct Context {
        let onRegistrationSuccess: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.registrationVC(onRegistrationSuccess: context.onRegistrationSuccess)
        return controller
    }
}
