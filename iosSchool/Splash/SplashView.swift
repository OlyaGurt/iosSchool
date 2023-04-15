import Foundation
import UIKit

protocol SplashView: UIView {
    func update(with data: SplashViewData)
}

class SplashViewImp: UIView, SplashView {

    func update(with data: SplashViewData) {
    }
}
