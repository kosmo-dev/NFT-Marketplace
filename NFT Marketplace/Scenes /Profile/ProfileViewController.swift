//
//  ProfileViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 26.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: - Private Properties
    private let userProfileStackView = UserProfileStackView()
    private let profileButtonsStackView = ProfileButtonsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold) // Вы можете настроить pointSize и weight.
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: configuration)
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightButtonTapped))
        barButtonItem.tintColor = .blackDayNight
        navigationItem.rightBarButtonItem = barButtonItem

        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(userProfileStackView)
        view.addSubview(profileButtonsStackView)
        
        userProfileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userProfileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userProfileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            profileButtonsStackView.topAnchor.constraint(equalTo: userProfileStackView.bottomAnchor, constant: 40),
            profileButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileButtonsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    @objc func rightButtonTapped() {
        
    }
}
