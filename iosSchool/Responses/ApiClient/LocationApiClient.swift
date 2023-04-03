import Foundation

protocol LocationApiClient {
    func location(
        onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void
    )
}

extension ApiClient: LocationApiClient {
    func location(onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void) {
        let url = NetworkConstants.URLStrings.location
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
