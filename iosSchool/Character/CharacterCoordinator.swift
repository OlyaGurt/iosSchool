import Foundation
import UIKit

class CharacterCoordinator: BaseCoordinator<CharacterCoordinator.Context> {
    struct Context {
        let viewModel: LocationCellData
    }

    override func make() -> UIViewController {
        let controller = assembly.characterVC(viewModel: context.viewModel)
        return controller
    }
}
