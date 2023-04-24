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

        DispatchQueue.global().async {
            self.apiClient.requestImageData(url: url, completion: { [weak self] result in
                guard let result else {
                    return
                }
                self?.updateQueue.async {
                    if self?.imageDict.count ?? 0 > 50 {
                        self?.imageDict.removeAll()
                    }
                    let image = UIImage(data: result)
                    self?.imageDict[url] = image
                    completion(image)
                }
            })
        }
    }
}
