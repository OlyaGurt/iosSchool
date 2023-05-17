import Foundation

protocol CabinetDataProvider {
    func getCabinet(
        cabinetId: String,
        completion: @escaping (Result<Cabinet, ApiError>) -> Void
    )
}

class CabinetDataProviderImp: CabinetDataProvider {

    private let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func getCabinet(
        cabinetId: String,
        completion: @escaping (Result<Cabinet, ApiError>) -> Void
    ) {
        apiClient.getCabinet(cabinetId: cabinetId) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
