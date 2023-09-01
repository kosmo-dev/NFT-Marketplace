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

    let catalogNavigationController: UINavigationController

    // TODO: Заменить вью контроллеры на свои
    init() {
    
        let dataProvider = DataProvider(networkClient: DefaultNetworkClient())
        let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)
        
        catalogViewController = CatalogViewController(presenter: catalogPresenter)
        cartViewController = CartViewController()
        profileViewController = UIViewController()
        statisticViewController = UIViewController()
        
        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
    }
}
