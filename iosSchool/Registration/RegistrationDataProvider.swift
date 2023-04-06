import Foundation

protocol RegistrationDataProdiver {
    func registration(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

class RegistrationDataProviderImp: RegistrationDataProdiver {

    private let apiClient: RegistrationApiClient

    init(apiClient: RegistrationApiClient) {
        self.apiClient = apiClient
    }

    func registration(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void) {
            apiClient.registration(username: username, password: password) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
