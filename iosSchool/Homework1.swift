import Foundation

let maxHealth = 100

protocol Creature {
    var name: String {get set }
    var attack: Int { get set }
    var protection: Int? { get set }
    var health: Int { get set }
}

enum PlayerLevel: Int {
    case low = 10
    case medium = 25
    case high = 50
}

class RandomGeterator {
    static func getParam() -> Int {
        return Int.random(in: 1...20)
    }

    static func getDamage() -> Int {
        return Int.random(in: 20..<maxHealth)
    }
}

class Player: Creature {
    private var counterOfHeal = 3
    var name: String
    var attack: Int
    var protection: Int?
    var health: Int
    var level: PlayerLevel

    init(name: String) {
        self.attack = RandomGeterator.getParam()
        self.protection = RandomGeterator.getParam()
        self.health = maxHealth
        self.level = .high
        self.name = name
    }

    func heal() {
        if self.counterOfHeal > 0 {
            self.health += self.level.rawValue
            if self.health > 100 {
                self.health = 100
            }
            self.counterOfHeal -= 1
        } else {
            print("Heal spell is empty!")
        }
    }
}

class Monster: Creature {
    var name: String
    var attack: Int
    var protection: Int?
    var health: Int

    init() {
        self.attack = RandomGeterator.getParam()
        self.protection = RandomGeterator.getParam()
        self.health = maxHealth
        self.name = "Monster"
    }
}

class Game {
    var attacker: Creature
    var defender: Creature

    init(attacker: Creature, defender: Creature) {
        self.attacker = attacker
        self.defender = defender
    }

    private func getModificator() -> Int {
        if ((self.attacker.attack - (self.defender.protection ?? 0)) + 1) < 1 {
            return 1
        } else {
            return (self.attacker.attack - (self.defender.protection ?? 0)) + 1
        }
    }

    func swapAttacker() {
        let attacker = self.attacker
        self.attacker = self.defender
        self.defender = attacker
    }
}
