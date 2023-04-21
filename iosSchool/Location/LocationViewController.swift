import UIKit

class LocationViewController<View: LocationView>: BaseViewController<View> {

    var selectLocation: ((LocationCellData) -> Void)?
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

        setupBar()
        rootView.makeView()
        rootView.selectLocation = selectLocation

        dataProvider.location { [weak self] result in
            switch result {
            case .success(let data):
                self?.rootView.update(with: LocationViewData(locations: data))
            case .failure(let failure):
                print(failure.rawValue)
                print("fail")
            }
        }
    }

// MARK: - Actions

    @objc
    private func reload() {
    }

// MARK: - Private

    private func setupBar() {
            title = "Выбор планеты"
            navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor(named: "DarkBlue") ?? .black,
                .font: UIFont.systemFont(ofSize: 18)
            ]
//            navigationItem.rightBarButtonItem = UIBarButtonItem(
//                barButtonSystemItem: .refresh,
//                target: self,
//                action: #selector(reload)
//            )
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: "reloadIcon"),
                style: .done,
                target: self,
                action: #selector(reload)
            )
        }
}
