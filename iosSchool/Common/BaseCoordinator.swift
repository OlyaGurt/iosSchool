import UIKit

class BaseCoordinator<Context> {

    let assembly: Assembly
    let context: Context

    init(assembly: Assembly, context: Context) {
        self.assembly = assembly
        self.context = context
    }

    func make() -> UIViewController {
        fatalError("method is abstact")
    }
}
