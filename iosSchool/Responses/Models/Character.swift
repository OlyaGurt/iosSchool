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

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case episode
        case url
        case created
    }
}
