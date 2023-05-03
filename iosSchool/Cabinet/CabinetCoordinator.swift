import UIKit

class CabinetCoordinator: BaseCoordinator<CabinetCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.cabinetVC()
        return controller
    }
}
