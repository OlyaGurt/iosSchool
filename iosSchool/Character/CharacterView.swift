import Foundation
import UIKit

protocol CharacterView: UIView {
    func update(with data: CharacterViewData)
}

class CharacterViewImp: UIView, CharacterView {
    func update(with data: CharacterViewData) {
    }
}
