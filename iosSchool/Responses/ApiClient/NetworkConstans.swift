import Foundation

struct NetworkConstants {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    struct URLStrings {
        static let location = "https://rickandmortyapi.com/api/location"
        static let nanoPost = "https://nanopost.evolitist.com/api"
    }
}
