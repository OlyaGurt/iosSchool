import Foundation
import UIKit

protocol CharacterView: UIView {
    func updage(with data: CharacterViewData)
}

class CharacterViewImp: UIView, CharacterView {
    func updage(with data: CharacterViewData) {
    }
}
