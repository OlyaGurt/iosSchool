import Foundation
import UIKit

class SplashViewController: UIViewController {
    private let dataProvider: SplashDataProvider

    private let onSuccess: (() -> Void)?

    init(dataProvider: SplashDataProvider, onSuccess: (() -> Void)?) {
        self.dataProvider = dataProvider
        self.onSuccess = onSuccess
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] timer in
            self?.onSuccess?()
            timer.invalidate()
        }
    }
}
