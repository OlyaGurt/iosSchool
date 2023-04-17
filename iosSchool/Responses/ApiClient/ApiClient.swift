import Foundation

class ApiClient {

    func performRequest<ResponseModel: Decodable> (
        url: String,
        data: Data?,
        method: NetworkConstants.HTTPMethod,
        onRequestCompleted: @escaping (Result<ResponseModel, ApiError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            onRequestCompleted(.failure(.dataParsing))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if method != .get, let data, !data.isEmpty {
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                onRequestCompleted(.failure(.serverError))
            } else if let data,
                let decodedValue: ResponseModel = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    onRequestCompleted(.success(decodedValue))
            } else {
                onRequestCompleted(.failure(.default(data)))
            }
        }
        task.resume()
    }

    func requestImageData(url: String, completion: ((Data?) -> Void)?) {
        guard let url = URL(string: url) else {
            completion?(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                completion?(nil)
            } else {
                completion?(data)
            }
        }
        task.resume()
    }
}
