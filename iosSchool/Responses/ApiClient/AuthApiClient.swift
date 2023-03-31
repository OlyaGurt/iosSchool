import Foundation

protocol AuthApiClient {
    func authorization(
        username: String,
        password: String,
        onRequestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

extension ApiClient: AuthApiClient {
    func authorization(
        username: String,
        password: String,
        onRequestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.nanoPost +
        "/auth/login?username=\(username)&password=\(password)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
