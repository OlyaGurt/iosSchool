import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
