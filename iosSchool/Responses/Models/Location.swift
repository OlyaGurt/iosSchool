import Foundation

struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
    let dim: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case residents
        case dim = "dimension"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = (try? container.decode(String.self, forKey: .type)) ?? "no type"
        self.residents = try container.decode([String].self, forKey: .residents)
        self.dim = try container.decode(String.self, forKey: .dim)
    }
}
