import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let defaults = UserDefaults.standard
        let isFirstLaunch = !defaults.bool(forKey: "HasLaunchedBefore")
        let appConfiguration = AppConfiguration()
        self.window = window

        if isFirstLaunch {
            defaults.set(true, forKey: "HasLaunchedBefore")
            window.rootViewController = OnboardingViewController()
        } else {
            window.rootViewController = TabBarController(appConfiguration: appConfiguration)
        }
        window.makeKeyAndVisible()
    }
}
