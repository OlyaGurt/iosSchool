import Foundation

protocol AuthDataProvider {
    func authorization(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

class AuthDataProviderImp: AuthDataProvider {

    private let apiClient: AuthApiClient

    init(apiClient: AuthApiClient) {
        self.apiClient = apiClient
    }

    func authorization(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        apiClient.authorization(username: username, password: password) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
