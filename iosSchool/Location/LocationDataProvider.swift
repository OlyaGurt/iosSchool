import Foundation

protocol LocationDataProvider {
    func location(page: Int, completion: @escaping (Result<LocationsList, ApiError>) -> Void)
}

class LocationDataProviderImp: LocationDataProvider {

    private let apiClient: LocationApiClient

    init(apiClient: LocationApiClient) {
        self.apiClient = apiClient
    }

    func location(page: Int, completion: @escaping (Result<LocationsList, ApiError>) -> Void) {
        apiClient.location(page: page) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
