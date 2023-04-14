import Foundation

struct LocationViewData {
    let cellVM: [LocationCellData]

    init(locations: LocationsList) {
        cellVM = locations.results.map { LocationCellData(
            location: $0,
            population: "Населеиние \($0.residents.count)"
        )}
    }
}
