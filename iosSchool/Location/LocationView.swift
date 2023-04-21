import Foundation
import UIKit

protocol LocationView: UIView {
    var selectLocation: ((LocationCellData) -> Void)? { get set }

    func update(with data: LocationViewData)
    func makeView()
}

class LocationViewImp: UIView, LocationView {

    var selectLocation: ((LocationCellData) -> Void)?

    private var locationData: LocationViewData?

    private let imageView = UIImageView()
    private let tableView = UITableView()

    func update(with data: LocationViewData) {
        locationData = data

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func makeView() {
        imageView.image = UIImage(named: "cellBackground")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: LocationCell.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LocationCell.className)
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

extension LocationViewImp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationData?.cellVM.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let locationData,
           let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.className) as? LocationCell {
            cell.viewModel = locationData.cellVM[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension LocationViewImp: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let locationData, locationData.cellVM.count > indexPath.row else {
            return
        }
        selectLocation?(locationData.cellVM[indexPath.row])
    }
}
