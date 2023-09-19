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
    let catalogNavigationController: UINavigationController
    var cartService: CartControllerProtocol

    let cartNavigationController: UINavigationController

    init() {
        let networkClient = DefaultNetworkClient()
        let profileService = ProfileService(networkClient: networkClient)
        let profilePresenter = ProfilePresenter(view: nil,
                                                profileService: profileService)
        profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.view = profileViewController as? ProfileViewProtocol

        cartService = CartService()
        let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
        let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)

        catalogViewController = CatalogViewController(presenter: catalogPresenter, cartService: cartService)
        profileViewController = UIViewController()
        statisticViewController = StatisticsViewController(
            presenter: StatisticsPresenter(userDataService: UserDataService()),
            cart: cartService)

        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)

        let cartPresenter = CartPresenter(cartController: cartService)
        cartService.delegate = cartPresenter
        cartViewController = CartViewController(presenter: cartPresenter)
        cartNavigationController = UINavigationController(rootViewController: cartViewController)
        cartPresenter.navigationController = cartNavigationController

    }
}
