import Foundation

protocol CharacterDataProvider {
    func character(characterId: String, completion: @escaping (Result<Character, ApiError>) -> Void)
}

class CharacterDataProviderImp: CharacterDataProvider {

    private let apiClient: CharacterApiClient

    init(apiClient: CharacterApiClient) {
        self.apiClient = apiClient
    }

    func character(characterId: String, completion: @escaping (Result<Character, ApiError>) -> Void) {
        apiClient.character(characterId: characterId) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
