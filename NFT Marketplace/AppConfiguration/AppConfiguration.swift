//
//  AppConfiguration.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

final class AppConfiguration {
    let profileViewController: UIViewController
    let catalogViewController: UIViewController
    let cartViewController: UIViewController
    let statisticViewController: UIViewController

    let cartNavigationController: UINavigationController

    // TODO: Заменить вью контроллеры на свои
    init() {
        profileViewController = UIViewController()
        catalogViewController = UIViewController()
        cartViewController = CartViewController()
        statisticViewController = UIViewController()

        cartNavigationController = UINavigationController(rootViewController: cartViewController)
    }
}
