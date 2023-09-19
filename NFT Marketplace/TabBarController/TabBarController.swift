//
//  TabBarController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    let appConfiguration: AppConfiguration

    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileNavigationController = UINavigationController(
            rootViewController: appConfiguration.profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.profileTabBarTitle,
            image: UIImage(systemName: "person.crop.circle.fill"),
            selectedImage: nil
        )

        appConfiguration.catalogViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.catalogTabBarTitle,
            image: UIImage(systemName: "rectangle.stack.fill"),
            selectedImage: nil
        )
        appConfiguration.cartViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.cartTabBarTitle,
            image: UIImage(named: "CartIcon"),
            selectedImage: nil
        )
        appConfiguration.statisticViewController.tabBarItem = UITabBarItem(
            title: TextLabels.TabBarController.statisticTabBarTitle,
            image: UIImage(systemName: "flag.2.crossed.fill"),
            selectedImage: nil
        )

        self.viewControllers = [
            profileNavigationController,
            appConfiguration.catalogViewController,
            appConfiguration.cartViewController,
            appConfiguration.catalogNavigationController,
            appConfiguration.cartNavigationController,
            appConfiguration.statisticViewController
        ]

        tabBar.isTranslucent = false
        view.tintColor = .blueUni
        tabBar.backgroundColor = .whiteDayNight
        tabBar.unselectedItemTintColor = .blackDayNight
        tabBar.tintColor = .blackDayNight

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .whiteDayNight
            appearance.shadowColor = nil
            appearance.stackedLayoutAppearance.normal.iconColor = .blackDayNight
            appearance.stackedLayoutAppearance.selected.iconColor = .blueUni
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
