import Foundation
import UIKit

class SplashCoordinator: BaseCoordinator<SplashCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.splashVC()
        return controller
    }

}
