import Foundation

protocol CharacterApiClient {
    func character(
        onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void
    )
}

extension ApiClient: CharacterApiClient {
    func character(onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void) {
        let url = NetworkConstants.URLStrings.character + "/821"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
