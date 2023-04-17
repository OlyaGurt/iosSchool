import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let species: String
    let gender: String
    let image: String
    let url: String
}
