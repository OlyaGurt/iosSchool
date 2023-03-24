import Foundation
import UIKit

class RegistrationCoordinator: BaseCoordinator<RegistrationCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.regVC()
        return controller
    }
}
