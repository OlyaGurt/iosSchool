import Foundation

struct LocationViewData {
    let cellVM: [LocationCellData]

    init(cells: [LocationCellData]) {
        cellVM = cells
    }
}
