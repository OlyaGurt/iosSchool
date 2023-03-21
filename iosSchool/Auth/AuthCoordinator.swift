import Foundation
import UIKit

class AuthCoordinator: BaseCoordinator<AuthCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.authVC()
        return controller
    }

}
