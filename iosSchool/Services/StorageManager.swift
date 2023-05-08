import Foundation
import KeychainAccess

protocol StorageManager {
    func cleanKeyChainNeeded()
    func saveToken(token: TokenResponse?)
    func getTocken() -> TokenResponse?
    func removeToken()
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

    func getTocken() -> TokenResponse? {
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



}

private extension StorageManagerImp {

    enum StorageManagerKey: String {
        case notFirstLaunch
        case token
        case userId
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
