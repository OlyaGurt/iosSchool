import Foundation

enum ApiError: Error {
    case dataParsing
    case serverError
    case `default`(Data?)

    var rawValue: String {
        switch self {
        case .dataParsing:
            return "Ошибка парсинга"
        case .serverError:
            return "Ошибка получения данных"
        case let .default(error):
            if let error {
                return String(decoding: error, as: UTF8.self)
            } else {
                return "Неизвестная ошибка"
            }
        }
    }
}
