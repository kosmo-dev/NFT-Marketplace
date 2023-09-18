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
    let cartService: CartControllerProtocol

<<<<<<< HEAD

//     TODO: Заменить вью контроллеры на свои
    init() {
        cartService = CartControllerStub()
        let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
        let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)

        catalogViewController = CatalogViewController(presenter: catalogPresenter)
=======
    init() {
        // MARK: - Эпик Дениса
        let networkClient = DefaultNetworkClient()
        let profileService = ProfileService(networkClient: networkClient)
        let profilePresenter = ProfilePresenter(view: nil,
                                                profileService: profileService)
        profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.view = profileViewController as? ProfileViewProtocol // устанавливаем view

        // MARK: - Эпик Джами
        catalogViewController = UIViewController()
>>>>>>> ProfileEpic
        cartViewController = CartViewController()
        profileViewController = UIViewController()
        statisticViewController = StatisticsViewController(
            presenter: StatisticsPresenter(userDataService: UserDataService()),
            cart: cartService)


        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
    }
    
    func assemblyCollectionScreen(with model: NFTCollection) -> UIViewController {
        let dataProvider = CollectionDataProvider(networkClient: DefaultNetworkClient())
        let cartController = CartController()
        let presenter = CatalogСollectionPresenter(nftModel: model, dataProvider: dataProvider, cartController: cartController)
        let vc = CatalogСollectionViewController(presenter: presenter)
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
}
