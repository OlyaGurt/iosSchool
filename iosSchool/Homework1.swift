import Foundation

let maxHealth = 100

protocol Creature {
    var name: String { get set }
    var attack: Int { get set }
    var protection: Int? { get set }
    var health: Int { get set }
}

protocol GameProtocol {
    var attacker: Creature { get set }
    var defender: Creature { get set }

    init(attacker: Creature, defender: Creature)

    func swapAttacker()
    func getModificator() -> Int
    func getSuccess() -> Bool
    func getInfo()
    func getAttack()
}

enum PlayerLevel: Int {
    case low = 10
    case medium = 25
    case high = 50
}

class RandomGeterator {
    static func getParam() -> Int {
        Int.random(in: 1...20)
    }

    static func getDamage() -> Int {
        Int.random(in: 20..<maxHealth)
    }

    static func getDice() -> Int {
        Int.random(in: 1..<7)
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

    init?(name: String, attack: Int, protection: Int?, health: Int, level: PlayerLevel) {
        guard attack <= 20 && attack >= 0 else {
            print("Invalid value \"attack\" entered. Please enter a number between 1 and 20.")
            return nil
        }
        self.attack = attack

        guard protection ?? 0 <= 20 && protection ?? 0 >= 0 else {
            print("Invalid value \"protection\" entered. Please enter a number between 1 and 20.")
            return nil
        }
        self.protection = protection

        guard health <= 100 && health >= 0 else {
            print("Invalid value \"health\" entered. Please enter a number between 1 and 100.")
            return nil
        }
        self.health = health

        self.level = level
        guard name.count <= 20 else {
            print("Too long name")
            return nil
        }
        self.name = name
    }

    func heal() {
        if counterOfHeal > 0 {
            health += level.rawValue
            if health > 100 {
                health = 100
            }
            counterOfHeal -= 1
        } else {
            print("Heal spell is empty!")
        }
    }
}

class Monster: Creature {
    var name: String = "Monster"
    var attack: Int
    var protection: Int?
    var health: Int

    init() {
        self.attack = RandomGeterator.getParam()
        self.protection = RandomGeterator.getParam()
        self.health = maxHealth
    }

    init?(attack: Int, protection: Int?, health: Int) {
        guard attack <= 20 && attack >= 0 else {
            print("Invalid value \"attack\" entered. Please enter a number between 1 and 20.")
            return nil
        }
        self.attack = attack

        guard protection ?? 0 <= 20 && protection ?? 0 >= 0 else {
            print("Invalid value \"protection\" entered. Please enter a number between 1 and 20.")
            return nil
        }
        self.protection = protection

        guard health <= 100 && health >= 0 else {
            print("Invalid value \"health\" entered. Please enter a number between 1 and 100.")
            return nil
        }
        self.health = health
    }
}

class Game: GameProtocol {
    var attacker: Creature
    var defender: Creature

    required init(attacker: Creature, defender: Creature) {
        self.attacker = attacker
        self.defender = defender
    }

    func swapAttacker() {
        let attacker = self.attacker
        self.attacker = self.defender
        self.defender = attacker
    }

    func getModificator() -> Int {
        if ((attacker.attack - (defender.protection ?? 0)) + 1) < 1 {
            return 1
        } else {
            return (attacker.attack - (defender.protection ?? 0)) + 1
        }
    }

    func getSuccess() -> Bool {
        let modificator = getModificator()
        for _ in 1...modificator where RandomGeterator.getDice() >= 5 {
            return true
        }
        return false
    }

    func getInfo() {
        print(
            """
            Attacker Info:
            name: \(attacker.name)
            protection: \(attacker.protection ?? 0)
            attack: \(attacker.attack)
            health: \(attacker.health)

            Defender Info:
            name: \(defender.name)
            protection: \(defender.protection ?? 0)
            attack: \(defender.attack)
            health: \(defender.health)
            ***
            """
        )
    }

    func getAttack() {
        if getSuccess() {
            let damage = RandomGeterator.getDamage()
            print(
            """

            ***
            !Damage dealt: \(damage)
            ---
            """
            )
            defender.health -= damage
            getInfo()
        } else {
            print(
            """

            ***
            Attack is missed :(
            ---
            """
            )
            getInfo()
        }
    }
}

class Fight {
    static func doFight() {
        let player = Player(
            name: "Olga Gurtueva",
            attack: 20,
            protection: 20,
            health: 1000,
            level: PlayerLevel.medium
        )
        let monster = Monster(
            attack: 10,
            protection: 10,
            health: 100
        )
        guard let player, let monster else {
            return
        }
        let game: GameProtocol = Game(attacker: player, defender: monster)
        var flag: Bool = false
        while player.health > 0 {
            if monster.health < 1 {
                flag = true
                break
            } else {
                game.getAttack()
                game.swapAttacker()
            }
        }
        if flag {
            print("\(player.name) win! ✓ ")
        } else {
            print("\(monster.name) win!")
        }
    }
}
