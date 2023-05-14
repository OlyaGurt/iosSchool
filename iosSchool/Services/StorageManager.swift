import Foundation
import KeychainAccess

protocol StorageManager {
    func cleanKeyChainNeeded()
    func saveToken(token: TokenResponse?)
    func getToken() -> TokenResponse?
    func removeToken()
    func saveLastLaunchDate()
    func getLastLaunchDate () -> String?
    func saveUsername(cabinet: Cabinet?)
    func getUsername() -> Cabinet?
}

class StorageManagerImp: StorageManager {

    private let keychein = Keychain(service: Constants.serviceId)

    func cleanKeyChainNeeded() {
        guard !notFirstLaunch() else {
            return
        }
        saveFirstLaunch()
        let keychain = Keychain(service: Constants.serviceId)
        do {
            try keychain.removeAll()
        } catch {
            print(error as Any)
        }
    }

    func saveToken(token: TokenResponse?) {
        guard let token else {
            return
        }
        do {
            try keychein.set(token.token, key: StorageManagerKey.token.rawValue)
            try keychein.set(token.userId, key: StorageManagerKey.userId.rawValue)
        } catch {
            print(error as Any)
        }
    }

    func getToken() -> TokenResponse? {
        do {
            guard let token = try keychein.get(StorageManagerKey.token.rawValue),
                  let userId = try keychein.get(StorageManagerKey.userId.rawValue) else {
                return nil
            }
            return TokenResponse(token: token, userId: userId)
        } catch {
            print(error as Any)
        }
        return nil
    }

    func removeToken() {
        do {
            try keychein.remove(StorageManagerKey.token.rawValue)
            try keychein.remove(StorageManagerKey.userId.rawValue)
        } catch {
            print(error as Any)
        }
    }

    func saveLastLaunchDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let result = dateFormatter.string(from: date)
        UserDefaults.standard.set(result, forKey: StorageManagerKey.lastLaunch.rawValue)
    }

    func getLastLaunchDate() -> String? {
        guard let date = UserDefaults.standard.string(forKey: StorageManagerKey.lastLaunch.rawValue) else {
            return nil
        }
        return date
    }

    func saveUsername(cabinet: Cabinet?) {
        guard let cabinet else {
            return
        }
        do {
            try keychein.set(cabinet.username, key: StorageManagerKey.username.rawValue)
        } catch {
            print(error as Any)
        }
    }

    func getUsername() -> Cabinet? {
        do {
            guard let username = try keychein.get(StorageManagerKey.username.rawValue) else {
                return nil
            }
            return Cabinet(username: username)
        } catch {
            print(error as Any)
        }
        return nil
    }
}

private extension StorageManagerImp {

    enum StorageManagerKey: String {
        case notFirstLaunch
        case token
        case userId
        case lastLaunch
        case username
    }

    struct Constants {
        static let serviceId = "StorageManagerKeychein.Service.Id"
    }

    func notFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: StorageManagerKey.notFirstLaunch.rawValue)
    }

    func saveFirstLaunch() {
        UserDefaults.standard.set(true, forKey: StorageManagerKey.notFirstLaunch.rawValue)
    }
}
