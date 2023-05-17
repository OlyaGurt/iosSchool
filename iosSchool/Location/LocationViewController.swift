import UIKit
import SPIndicator
import PKHUD

class LocationViewController<View: LocationView>: BaseViewController<View> {

    var selectLocation: ((LocationCellData) -> Void)?
    private var page: Int = 1
    private var cellsVM: [LocationCellData] = []
    private var pagesLimited: Bool = false
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
        rootView.update(with: .init(cells: cellsVM))
        pagesLimited = false
        loadPage(page)
    }

// MARK: - Private

    private func loadPage(_ page: Int) {
        guard !pagesLimited else {
            return
        }
        HUD.show(.progress)
        dataProvider.location(page: page) { [weak self] result in
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                HUD.hide()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "reloadIcon"),
            style: .done,
            target: self,
            action: #selector(reload)
        )
    }
}
