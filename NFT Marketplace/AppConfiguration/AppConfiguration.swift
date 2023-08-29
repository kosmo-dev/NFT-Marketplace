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
        //MARK: - Эпик Дениса
        let networkClient = DefaultNetworkClient()
        let profileService = ProfileService(networkClient: networkClient)
        let profilePresenter = ProfilePresenter(view: nil, profileService: profileService) // Временно установим view в nil
        profileViewController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.view = profileViewController as? ProfileViewProtocol // Теперь устанавливаем view
        
        //MARK: - Эпик Джами
        catalogViewController = UIViewController()
        cartViewController = CartViewController()
        statisticViewController = UIViewController()
    }
}
