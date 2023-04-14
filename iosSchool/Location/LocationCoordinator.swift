import Foundation
import UIKit

class LocationCoordinator: BaseCoordinator<LocationCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.locationVC()
        controller.selectLocation = { [weak controller] locationVM in
            let coordonator = self.assembly.characterCoordinator()
            let characterVC = coordonator.make()
            controller?.navigationController?.pushViewController(characterVC, animated: true)
        }
        return controller
    }
}
