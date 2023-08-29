//
//  AppConfiguration.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

class AppConfiguration {
    let profileViewController: UIViewController
    let catalogViewController: UIViewController
    let cartViewController: UIViewController
    let statisticViewController: UIViewController

    // TODO: Заменить вью контроллеры на свои
    init() {
        profileViewController = UIViewController()
        catalogViewController = UIViewController()
        cartViewController = CartViewController()
        statisticViewController = StatisticsViewController(presenter:  StatisticsPresenter())
    }
}
