import Foundation

class Assembly {

    var apiClient: ApiClient {
        ApiClient()
    }

    func colorGeneratore(alpha: Double) -> ColorGenerator {
        ColorGenerator(alpha: alpha)
    }

    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, context: CoordinatorContext())
    }
}
