import Foundation

protocol Creature {
    var attack: Int { get set }
    var protection: Int? { get set }
    var health: Int { get set }
}

enum PlayerLevel: Double {
case low = 0.1
case medium = 0.25
case high = 0.5
}
