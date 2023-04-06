import UIKit

class LocationViewController<View: LocationView>: BaseViewController<View> {

    private let dataProvider: LocationDataProvider

    init(dataProvider: LocationDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataProvider.location { [weak self] result in
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
