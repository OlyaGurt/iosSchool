import Foundation

class Assembly {

    func colorGeneratore(alpha: Double) -> ColorGenerator {
        ColorGenerator(alpha: alpha)
    }

    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, context: CoordinatorContext())
    }
}
