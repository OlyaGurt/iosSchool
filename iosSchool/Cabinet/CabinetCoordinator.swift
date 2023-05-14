import UIKit

class CabinetCoordinator: BaseCoordinator<CabinetCoordinator.Context> {

    struct Context {
        let escapeToAuth: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.cabinetVC(escapeToAuth: context.escapeToAuth)
        return controller
    }
}
