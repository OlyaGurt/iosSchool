import Foundation

protocol CharacterApiClient {
    func character(
        characterId: String,
        onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void
    )
    func singleCharacter(
        url: String,
        completion: @escaping (Result<Character, ApiError>) -> Void
    )
}

extension ApiClient: CharacterApiClient {
    func character(
        characterId: String,
        onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.character + "/" + characterId
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }

    func singleCharacter(
        url: String,
        completion onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void
    ) {
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
