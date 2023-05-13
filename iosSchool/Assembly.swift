import Foundation
import UIKit

class Assembly {

    var apiClient: ApiClient {
        ApiClient()
    }

    lazy var imageService: ImageService = ImageServiceImp(apiClient: apiClient)
    lazy var storageManager: StorageManager = StorageManagerImp()

    func colorGeneratore(alpha: Double) -> ColorGenerator {
        ColorGenerator(alpha: alpha)
    }

    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, context: CoordinatorContext())
    }

    func rootTabBarController() -> UITabBarController {
        TabBarController()
    }

    func rootNavigationController() -> UINavigationController {
        let controller = BaseNavigationController()
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
