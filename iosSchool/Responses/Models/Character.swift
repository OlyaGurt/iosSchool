import Foundation

struct Character: Decodable {

    enum Status: String, Decodable {
        case alive
        case dead
        case unknown
    }

    enum Gender: String, Decodable {
        case female
        case male
        case genderless
        case unknown
    }

    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let episode: [String]
    let url: String
    let created: String
}
