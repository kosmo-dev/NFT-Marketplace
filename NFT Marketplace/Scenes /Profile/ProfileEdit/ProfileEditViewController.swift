//
//  ProfileEditViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 31.08.2023.
//

import UIKit

final class ProfileEditViewController: UIViewController {
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.tintColor = .blackDayNight
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let profileAvatarView = ProfileEditUserPicture(frame: CGRect(x: 0, y: 0, width: 70, height: 70), image: UIImage(named: "Profile_placeholder"), text: "Cменить\nфото")
    
    private lazy var nameStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: "Имя", textContent: "Введите ваше имя")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var descriptionStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: "Описание", textContent: "Введите ваше описание")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var websiteStackView: ProfileEditStackView = {
       let stack = ProfileEditStackView(labelText: "Сайт", textContent: "Введите ваш Веб-сайт")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        
        setupLayout()
        // Добавляем распознаватель тапов для закрытия клавиатуры
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         view.addGestureRecognizer(tapGesture)
    }
    
    private func setupLayout() {
        view.addSubview(doneButton)
        view.addSubview(profileAvatarView)
        view.addSubview(nameStackView)
        view.addSubview(descriptionStackView)
        view.addSubview(websiteStackView)
        profileAvatarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileAvatarView.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 22),
            profileAvatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileAvatarView.widthAnchor.constraint(equalToConstant: 70),
            profileAvatarView.heightAnchor.constraint(equalToConstant: 70),
            nameStackView.topAnchor.constraint(equalTo: profileAvatarView.bottomAnchor, constant: 20),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 24),
            descriptionStackView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor),
            descriptionStackView.trailingAnchor.constraint(equalTo: nameStackView.trailingAnchor),
            websiteStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 24),
            websiteStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            websiteStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor)
        ])
    }
    
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
