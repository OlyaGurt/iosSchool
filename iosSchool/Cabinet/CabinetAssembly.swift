import Foundation
import UIKit

protocol CabinetAssembly {
    func cabinetCoodrinator() -> CabinetCoordinator
    func cabinetVC() -> CabinetViewController
}

extension Assembly: CabinetAssembly {

    func cabinetCoodrinator() -> CabinetCoordinator {
        CabinetCoordinator(assembly: self, context: .init())
    }

    func cabinetVC() -> CabinetViewController {
        .init()
    }
}
