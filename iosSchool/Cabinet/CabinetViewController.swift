import Foundation
import UIKit

class CabinetViewController<View: CabinetView>: BaseViewController<View> {
    override func viewDidLoad() {
        rootView.backgroundColor = .white
        rootView.makeView()
        super.viewDidLoad()
    }
}

extension CabinetViewController: CabinetViewDelegate {
    func backButtonDidTap() {
        }
}
