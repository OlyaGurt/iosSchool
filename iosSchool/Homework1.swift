import Foundation

protocol Creature {
    var attack: Int { get set }
    var protection: Int? { get set }
    var health: Int { get set }
}
