import Foundation
import UIKit

class LocationCoordinator: BaseCoordinator<LocationCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.locationVC()
        return controller
    }
}
