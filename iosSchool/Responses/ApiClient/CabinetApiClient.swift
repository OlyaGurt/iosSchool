import Foundation

protocol CabinetApiClient {
    func getCabinet(
        cabinetId: String,
        onRequestComplited: @escaping (Result<Cabinet, ApiError>) -> Void
    )
}

extension ApiClient: CabinetApiClient {
    func getCabinet(
        cabinetId: String,
        onRequestComplited: @escaping (Result<Cabinet, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.nanoPost + "/v1/posts/" + cabinetId
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestComplited)
    }
}
