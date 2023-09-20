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
//        let appConfig = AppConfiguration()
//        let tabBarController = TabBarController(appConfiguration: appConfig)
        let onboardingViewController = OnboardingViewController()
        window.rootViewController = onboardingViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
