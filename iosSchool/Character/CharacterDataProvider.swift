import Foundation

protocol CharacterDataProvider {
    func character(
        completion: @escaping (Result<Character, ApiError>) -> Void
    )
}

class CharacterDataProviderImp: CharacterDataProvider {

    private let apiClient: CharacterApiClient

    init(apiClient: CharacterApiClient) {
        self.apiClient = apiClient
    }

    func character(completion: @escaping (Result<Character, ApiError>) -> Void) {
        apiClient.character { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
