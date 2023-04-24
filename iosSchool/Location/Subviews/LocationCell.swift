import UIKit

class LocationCell: UITableViewCell {

    var viewModel: LocationCellData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var typeLocationLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!

    private func update(_ viewModel: LocationCellData?) {
        guard let viewModel else {
            return
        }
        locationLabel.text = viewModel.name
        locationLabel.font = .boldSystemFont(ofSize: 18)
        typeLocationLabel.text = viewModel.type
        populationLabel.text = viewModel.population
    }
}
