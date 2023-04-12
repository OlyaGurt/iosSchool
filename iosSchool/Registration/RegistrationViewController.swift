import UIKit

class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {

    var closeRegistration: (() -> Void)?

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
        rootView.update(with: RegistrationViewData())
        rootView.backAction = closeRegistration
        dataProvider.registration(username: "olyagurt", password: "1111") { [weak self] result in
            switch result {
            case .success(let response):
                print("success")
                print(response)
            case .failure(let failure):
                print(failure.rawValue)
                print("fail")
            }
        }
    }
}
