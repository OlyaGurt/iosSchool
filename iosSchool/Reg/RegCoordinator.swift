import Foundation
import UIKit

class RegCoordinator: BaseCoordinator<RegCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.regVC()
        return controller
    }
}
