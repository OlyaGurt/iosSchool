import Foundation

protocol AuthDataProvider {
    func authorization(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    )

    func getCabinet(
        cabinetId: String,
        completion: @escaping (Result<Cabinet, ApiError>) -> Void
    )
}

class AuthDataProviderImp: AuthDataProvider {

    private let apiClient: AuthApiClient
    private let cabinetApiClient: CabinetApiClient

    init(apiClient: AuthApiClient, cabinetApiClient: CabinetApiClient) {
        self.apiClient = apiClient
        self.cabinetApiClient = cabinetApiClient
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

    func getCabinet(
        cabinetId: String,
        completion: @escaping (Result<Cabinet, ApiError>) -> Void
    ) {
        cabinetApiClient.getCabinet(cabinetId: cabinetId) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
