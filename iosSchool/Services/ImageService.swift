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
        if let image = imageDict[url] {
            completion(image)
        }
        if imageDict.count > 50 {
            imageDict.removeAll()
        }
        DispatchQueue.global().async {
            self.apiClient.requestImageData(url: url) { [weak self] result in
                guard let result else {
                    completion(nil)
                    return
                }
                guard let image = UIImage(data: result) else {
                    completion(nil)
                    return
                }
                self?.updateQueue.async {
                    self?.imageDict[url] = image
                    completion(image)
                }
            }
        }
    }
}
