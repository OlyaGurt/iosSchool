import Foundation
import UIKit

protocol ImageService {
    func getImage(url: String, completion: @escaping (UIImage?) -> Void)
}

class ImageServiceImp: ImageService {

    private var imageDict: [String: UIImage] = [:]

    private let apiClient: ApiClient
    private let updateQueue = DispatchQueue(label: "ImageServiceQueue")

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
    }
}
