import Foundation
import UIKit

class CabinetViewController<View: CabinetView>: BaseViewController<View> {

    var escapeToAuth: (() -> Void)?

    private var storageManager: StorageManager

    init(escapeToAuth: (() -> Void)?, storageManager: StorageManager) {
        self.escapeToAuth = escapeToAuth
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
        rootView.delegate = self
        rootView.update(data: CabinetViewData(
            loginCell: LoginLabelCellData(loginLabel: storageManager.getUsername()),
            fieldCell: FieldCellData(
                date: storageManager.getLastLaunchDate(),
                color: nil,
                colorIsHidden: true
            )))
    }
}

extension CabinetViewController: CabinetViewDelegate {
    func backButtonDidTap() {
        storageManager.removeToken()
        storageManager.removeUsername()
        self.escapeToAuth?()
    }
}
