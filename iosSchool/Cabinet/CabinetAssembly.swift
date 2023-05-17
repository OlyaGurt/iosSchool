import Foundation
import UIKit

protocol CabinetAssembly {
    func cabinetCoodrinator(escapeToAuth: (() -> Void)?) -> CabinetCoordinator
    func cabinetVC(escapeToAuth: (() -> Void)?) -> CabinetViewController<CabinetViewImp>
    func cabinetDataProvider() -> CabinetDataProvider
}

extension Assembly: CabinetAssembly {

    func cabinetCoodrinator(escapeToAuth: (() -> Void)?) -> CabinetCoordinator {
        CabinetCoordinator(assembly: self, context: .init(escapeToAuth: escapeToAuth))
    }

    func cabinetVC(escapeToAuth: (() -> Void)?) -> CabinetViewController<CabinetViewImp> {
        .init(escapeToAuth: escapeToAuth, storageManager: storageManager)
    }

    func cabinetDataProvider() -> CabinetDataProvider {
        CabinetDataProviderImp(apiClient: apiClient)
    }
}
