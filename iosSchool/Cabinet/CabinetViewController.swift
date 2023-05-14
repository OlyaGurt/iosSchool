import Foundation
import UIKit

class CabinetViewController<View: CabinetView>: BaseViewController<View> {

    private var storageManager: StorageManager

    init(storageManager: StorageManager) {
        self.storageManager = storageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = .white
        rootView.makeView()
        rootView.update(data: CabinetViewData(fieldCell: FieldCellData(
            date: storageManager.getLastLaunchDate(),
            color: nil,
            colorIsHidden: true
        )))
    }
}

extension CabinetViewController: CabinetViewDelegate {
    func backButtonDidTap() {
    }
}
