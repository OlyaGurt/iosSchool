import UIKit

class RegistrationViewController: UIViewController {
    private let dataProvider: RegistrationDataProdiver

    init(dataProvider: RegistrationDataProdiver) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
