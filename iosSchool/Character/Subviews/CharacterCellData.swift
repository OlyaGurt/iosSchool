import Foundation
import UIKit

struct CharacterCellData {
    let url: String
    let isLoading: Bool
    let imageUrl: String?
    let image: UIImage?
    let name: String?
    let type: String?
    let gender: String?

    init(url: String) {
        self.url = url
        isLoading = true
        imageUrl = nil
        image = nil
        name = nil
        type = nil
        gender = nil
    }

    init(character: Character, isLoading: Bool, image: UIImage?) {
        url = character.url
        self.isLoading = isLoading
        imageUrl = character.image
        self.image = image
        name = character.name
        type = character.species
        gender = character.gender
    }
}
