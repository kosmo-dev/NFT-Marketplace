//
//  UserCardViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit

final class UserCardViewController: UIViewController {
    var presenter: UserCardPresenter?
    
    private let userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.layer.cornerRadius = userAvatar.bounds.height / 2
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userAvatar.image = UIImage(named: "UserPhoto")
        return userAvatar
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textColor = .blackDayNight
        userName.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return userName
    }()
    
    private let userDescription: UILabel = {
        let userDescription = UILabel()
        userDescription.translatesAutoresizingMaskIntoConstraints = false
        userDescription.numberOfLines = 0
        userDescription.lineBreakMode = .byWordWrapping
        userDescription.textColor = .blackDayNight
        userDescription.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        userDescription.sizeToFit()
        return userDescription
    }()
    
    private lazy var backwardButton: UIButton = {
        let backwardButton = UIButton(type: .custom)
        backwardButton.setImage(UIImage(named: "Backward"), for: .normal)
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.addTarget(self, action: #selector(backwardTapped), for: .touchUpInside)
        return backwardButton
    }()
    
    private lazy var userWebsiteButton: UIButton = {
        let userWebsiteButton = UIButton(type: .custom)
        userWebsiteButton.layer.cornerRadius = 16
        userWebsiteButton.setTitle("Перейти на сайт пользователя", for: .normal)  // перенести в файл стрингов
        userWebsiteButton.setTitleColor(UIColor.blackDayNight, for: .normal)
        userWebsiteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        userWebsiteButton.backgroundColor = .white
        userWebsiteButton.layer.borderWidth = 1
        
        let borderColor = UIColor.blackDayNight
        userWebsiteButton.layer.borderColor = borderColor.cgColor
        userWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        userWebsiteButton.addTarget(self, action: #selector(userWebsiteTapped), for: .touchUpInside)
        return userWebsiteButton
    }()
    
    private lazy var userCollectionsButton: UIButton = {
        let userCollectionsButton = UIButton(type: .custom)
        userCollectionsButton.setTitleColor(UIColor.blackDayNight, for: .normal)
        userCollectionsButton.titleLabel?.textColor = .blackDayNight
        userCollectionsButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        userCollectionsButton.contentHorizontalAlignment = .left
        userCollectionsButton.translatesAutoresizingMaskIntoConstraints = false
        userCollectionsButton.addTarget(self, action: #selector(userCollectionsTapped), for: .touchUpInside)
        return userCollectionsButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userDescription, userWebsiteButton])
        stackView.axis = .vertical
        stackView.spacing = 28
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let chevron: UIImageView = {
        let chevron = UIImageView()
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.image = UIImage(named: "chevron")
        return chevron
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupUserInfo()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backwardButton)
    }
    
    @objc private func backwardTapped() {
        dismiss(animated: true)
    }
    
    @objc private func userWebsiteTapped() {
        
    }
    
    @objc private func userCollectionsTapped() {
        // TODO: переход на страницу с коллекциями пользователя UsersCollectoinViewController()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            backwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backwardButton.heightAnchor.constraint(equalToConstant: 24),
            
            userAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62),
            userAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userAvatar.heightAnchor.constraint(equalToConstant: 70),
            userAvatar.widthAnchor.constraint(equalToConstant: 70),
            
            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 16),
            userName.centerYAnchor.constraint(equalTo: userAvatar.centerYAnchor),
            
            userDescription.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 20),
            userDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            stackView.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            userWebsiteButton.topAnchor.constraint(equalTo: userDescription.bottomAnchor, constant: 28),
            userWebsiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userWebsiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userWebsiteButton.heightAnchor.constraint(equalToConstant: 40),
            
            userCollectionsButton.topAnchor.constraint(equalTo: userWebsiteButton.bottomAnchor, constant: 40),
            userCollectionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userCollectionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userCollectionsButton.heightAnchor.constraint(equalToConstant: 54),
            
            chevron.centerYAnchor.constraint(equalTo: userCollectionsButton.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(userAvatar)
        view.addSubview(userName)
        view.addSubview(stackView)
        view.addSubview(userDescription)
        view.addSubview(backwardButton)
        view.addSubview(userWebsiteButton)
        view.addSubview(userCollectionsButton)
        userCollectionsButton.addSubview(chevron)
    }
    
    private func setupUserInfo() {
        userName.text = presenter?.getUserName()
        userDescription.text = presenter?.getUserDescription()
        userCollectionsButton.setTitle("Коллекция NFT"+" (\(presenter?.getNFT() ?? ""))", for: .normal)
    }
}
