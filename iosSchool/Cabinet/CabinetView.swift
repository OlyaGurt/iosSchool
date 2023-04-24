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

    private let tableView = UITableView()
    private let backButton = CustomButton()

    func update() {
    }

    func makeView() {
        tableView.backgroundColor = UIColor(named: "NewLilac80")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never

        let cabinetNib = UINib(nibName: CabinetIconCell.className, bundle: nil)
        tableView.register(cabinetNib, forCellReuseIdentifier: CabinetIconCell.className)
        addSubview(tableView)
        let loginNib = UINib(nibName: LoginLabelCell.className, bundle: nil)
        tableView.register(loginNib, forCellReuseIdentifier: LoginLabelCell.className)
        addSubview(tableView)
        let fieldNib = UINib(nibName: FieldCell.className, bundle: nil)
        tableView.register(fieldNib, forCellReuseIdentifier: FieldCell.className)
        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        addSubview(backButton)
        makeButton(button: backButton)
    }

// MARK: - Private methods

    private func makeButton(button: CustomButton) {
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
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -46).isActive = true
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

        if indexPath.row == 0 {
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: CabinetIconCell.className,
                for: indexPath
            ) as? CabinetIconCell {
                return customCell
            }
        }

        if indexPath.row == 1 {
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: LoginLabelCell.className,
                for: indexPath
            ) as? LoginLabelCell {
                return customCell
            }
        }

        if indexPath.row == 2 {
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: FieldCell.className,
                for: indexPath
            ) as? FieldCell {
                customCell.makeField()
                customCell.makeLabel(textLabel: "Дата регистрации", date: "11.10.2023")
                customCell.makeColorView(color: .clear)
                return customCell
            }
        }

        if indexPath.row == 3 {
            if let customCell = tableView.dequeueReusableCell(
                withIdentifier: FieldCell.className,
                for: indexPath
            ) as? FieldCell {
                customCell.makeField()
                customCell.makeLabel(textLabel: "Цвет профиля", date: "")
                customCell.makeColorView(color: UIColor(named: "Blue") ?? .clear)
                return customCell
            }
        }
        return UITableViewCell()
    }
}
