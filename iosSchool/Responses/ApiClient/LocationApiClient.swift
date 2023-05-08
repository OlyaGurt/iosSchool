import Foundation

protocol LocationApiClient {
    func location(
        page: Int,
        onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void
    )
}

extension ApiClient: LocationApiClient {
    func location(page: Int, onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void) {
        let url = NetworkConstants.URLStrings.location + "?page=\(page)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
