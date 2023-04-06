import Foundation
import UIKit

class CharacterCoordinator: BaseCoordinator<CharacterCoordinator.Context> {
    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.characterVC()
        return controller
    }
}
