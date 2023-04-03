import Foundation
import UIKit

protocol LocationView: UIView {
    func updage(with data: LocationViewData)
}

class LocationViewImp: UIView, LocationView {
    func updage(with data: LocationViewData) {
    }
}
