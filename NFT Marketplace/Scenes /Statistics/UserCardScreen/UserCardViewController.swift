//
//  UserCardViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit

final class UserCardViewController: UIViewController {

    private let userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userAvatar.image = UIImage(named: "UserPhoto")
        return userAvatar
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Joaquin Phoenix"
        userName.textColor = .blackDayNight
        userName.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return userName
    }()

    private let userDescription: UILabel = {
        let userDescription = UILabel()
        userDescription.translatesAutoresizingMaskIntoConstraints = false
        userDescription.text = "Ничего не найденоzg`fg`sgfzgsg`sdhjfb` zksdjhg` `sdjh`bdf`a sdjh`bdkjf`a d s`dhgb`djfhb`lad djh`bdljhabgl`jahb" // сделать построчный перенос текста
        userDescription.numberOfLines = 10 // сделать по количеству загруженных строк
        userDescription.textColor = .blackDayNight
        userDescription.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return userDescription
    }()
    
    private lazy var userWebsiteButton: UIButton = {
        let userWebsiteButton = UIButton(type: .custom)
        userWebsiteButton.titleLabel?.text = "Перейти на сайт пользователя" // перенести в файл стрингов
        userWebsiteButton.titleLabel?.textColor = .blackDayNight
        userWebsiteButton.backgroundColor = .clear
        userWebsiteButton.layer.borderWidth = 0.1
//        userWebsiteButton.layer.borderColor = CGColor
        userWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        userWebsiteButton.addTarget(self, action: #selector(userWebsiteTapped), for: .touchUpInside)
        return userWebsiteButton
    }()
    
    private lazy var userCollectionsButton: UIButton = {
        let userCollectionsButton = UIButton(type: .custom)
        userCollectionsButton.titleLabel?.text = "Коллекция NFT"+"\(12)"
        userCollectionsButton.titleLabel?.textColor = .blackDayNight
        userCollectionsButton.translatesAutoresizingMaskIntoConstraints = false
        userCollectionsButton.addTarget(self, action: #selector(userCollectionsTapped), for: .touchUpInside)
        return userCollectionsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc private func userWebsiteTapped() {
        
    }

    @objc private func userCollectionsTapped() {
        
    }
    
}
