import UIKit
import SPIndicator

class LocationViewController<View: LocationView>: BaseViewController<View> {

    var selectLocation: ((LocationCellData) -> Void)?
    var page: Int = 1
    var cellsVM: [LocationCellData] = []
    var pagesLimited: Bool = false
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
        rootView.willDisplayCell = { [weak self] indexPath in
            guard let self,
                    self.cellsVM.count > 0,
                    self.cellsVM.count / 2 == indexPath.row
            else {
                return
            }
            self.loadPage(self.page)
        }
        loadPage(page)
    }

// MARK: - Actions

    @objc
    private func reload() {
        page = 1
        cellsVM = []
        pagesLimited = false
        loadPage(page)
    }

// MARK: - Private

    private func loadPage(_ page: Int) {
        guard !pagesLimited else {
            return
        }
        dataProvider.location(page: page) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let newCells = data.results.map { LocationCellData(
                        location: $0,
                        population: "Население: \($0.residents.count)"
                    )}
                    self.cellsVM.append(contentsOf: newCells)
                    self.rootView.update(with: .init(cells: self.cellsVM))
                    self.pagesLimited = self.page == data.info.pages
                    if page < data.info.pages {
                        self.page += 1
                    }
                }
            case .failure(let data):
                DispatchQueue.main.async {
                    SPIndicator.present(title: data.rawValue, preset: .error, haptic: .error)
                }
            }
        }
    }

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
                image: UIImage(named: "reload"),
                style: .done,
                target: self,
                action: #selector(reload)
            )
        }
}
