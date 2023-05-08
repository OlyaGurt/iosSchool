import Foundation
import UIKit

protocol CabinetView: UIView {

    var delegate: CabinetViewDelegate? { get set }

    func update()
    func makeView()
}

protocol CabinetViewDelegate: AnyObject {
    func backButtonDidTap()
}

class CabinetViewImp: UIView, CabinetView {

    weak var delegate: CabinetViewDelegate?

    private let backgroundView = UIView()
    private let tableView = UITableView()
    private let backButton = CustomButton()

    func update() {
    }

    func makeView() {
        makeBackgroundView()

        self.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear

        let cabinetNib = UINib(nibName: CabinetIconCell.className, bundle: nil)
        tableView.register(cabinetNib, forCellReuseIdentifier: CabinetIconCell.className)
        addSubview(tableView)
        let loginNib = UINib(nibName: LoginLabelCell.className, bundle: nil)
        tableView.register(loginNib, forCellReuseIdentifier: LoginLabelCell.className)
        addSubview(tableView)
        let fieldNib = UINib(nibName: FieldCell.className, bundle: nil)
        tableView.register(fieldNib, forCellReuseIdentifier: FieldCell.className)
        tableView.delegate = self
        addSubview(tableView)

        makeButton(button: backButton)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(greaterThanOrEqualTo: backButton.topAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

// MARK: - Private methods

    private func makeBackgroundView() {
        addSubview(backgroundView)
        backgroundView.backgroundColor = UIColor(named: "Lilac80")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    private func makeButton(button: CustomButton) {
        addSubview(backButton)
        backButton.backgroundColor = UIColor(named: "VelvetBlue")
        backButton.normalColor = UIColor(named: "VelvetBlue") ?? .white
        backButton.highlightColor = .white
        backButton.setTitleColor(.black, for: .highlighted)
        backButton.layer.cornerRadius = 10
        backButton.layer.borderColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.22).cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.shadowOpacity = 0.25
        backButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        backButton.layer.shadowRadius = 4
        backButton.setTitle("Выйти", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

// MARK: - ObjFunctions

    @objc func backButtonDidTap(sender: UIButton) {
        delegate?.backButtonDidTap()
    }
}

// MARK: - UITableViewDataSource

extension CabinetViewImp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: CabinetIconCell.className,
                for: indexPath
            ) as? CabinetIconCell {
                return customCell
            }
        case 1:
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: LoginLabelCell.className,
                for: indexPath
            ) as? LoginLabelCell {
                return customCell
            }
        case 2:
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: FieldCell.className,
                for: indexPath
            ) as? FieldCell {
                let viewModel = FieldCellData(
                    textLabel: "Дата регистрации",
                    date: "11.10.2000",
                    color: nil,
                    colorIsHidden: true
                )
                customCell.viewModel = viewModel
                return customCell
            }
        case 3:
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: FieldCell.className,
                for: indexPath
            ) as? FieldCell {
                let viewModel = FieldCellData(
                    textLabel: "Цвет профиля",
                    date: nil,
                    color: .blue,
                    colorIsHidden: false
                )
                customCell.viewModel = viewModel
                return customCell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension CabinetViewImp: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return UIScreen.main.bounds.height > 800 ? tableView.rowHeight : 60
        }
        return tableView.rowHeight
    }
}
