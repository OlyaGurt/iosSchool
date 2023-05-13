import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal lazy var assembly = Assembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        assembly.storageManager.cleanKeyChainNeeded()
        assembly.storageManager.saveLastLaunchDate()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting
                     connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
