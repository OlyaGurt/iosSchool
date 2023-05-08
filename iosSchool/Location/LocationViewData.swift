import Foundation

struct LocationViewData {
    let cellVM: [LocationCellData]

    init(locations: LocationsList) {
        cellVM = locations.results.map { LocationCellData(
            location: $0,
            population: "Население: \($0.residents.count)"
        )}
    }
}
