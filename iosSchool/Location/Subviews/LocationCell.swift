import UIKit

class LocationCell: UITableViewCell {

    var viewModel: LocationCellData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var locationLable: UILabel!
    @IBOutlet private weak var typeLocationLable: UILabel!
    @IBOutlet private weak var populationLable: UILabel!

    private func update(_ viewModel: LocationCellData?) {
        guard let viewModel else {
            return
        }
        locationLable.text = viewModel.name
        locationLable.font = .boldSystemFont(ofSize: 18)
        typeLocationLable.text = viewModel.type
        populationLable.text = viewModel.population
    }
}
