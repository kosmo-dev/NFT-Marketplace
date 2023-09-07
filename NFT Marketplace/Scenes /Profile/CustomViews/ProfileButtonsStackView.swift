//
//  NFTButtonsStackView.swift
//  NFT Marketplace
//
//  Created by Денис on 27.08.2023.
//

import UIKit

final class ProfileButtonsStackView: UIView {
    private let userNFTButton = ProfileButton()
    private let userFavoritesNFTButton = ProfileButton()
    private let aboutDeveloperButton = ProfileButton()
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [userNFTButton, userFavoritesNFTButton, aboutDeveloperButton])
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        setupButtonsStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    /// Временный метод для начальной настройки Вью
    private func setupButtons() {
        userNFTButton.setText(TextLabels.ProfileButtonsStackView.myNFTLabel + " " + "(0)")
        userFavoritesNFTButton.setText(TextLabels.ProfileButtonsStackView.favoritesNFTLabel + " " + "(0)")
        aboutDeveloperButton.setText(TextLabels.ProfileButtonsStackView.aboutDeveloperLabel)
    }

    private func setupButtonsStackView() {
        addSubview(buttonsStackView)

        [userNFTButton, userFavoritesNFTButton, aboutDeveloperButton].forEach {
            buttonsStackView.addArrangedSubview($0)
        }

        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }

    func setButtonText(button1Text: String, button2Text: String, button3Text: String, counts: [Int]) {
        userNFTButton.setText("\(button1Text) (\(counts[0]))")
        userFavoritesNFTButton.setText("\(button2Text) (\(counts[1]))")
        aboutDeveloperButton.setText("\(button3Text)")
    }
}

extension ProfileButtonsStackView {
    func update(with profile: UserProfile) {
        let myNFTCount = profile.nfts.count
        let favouritesCount = profile.likes.count
        setButtonText(button1Text: TextLabels.ProfileButtonsStackView.myNFTLabel,
                      button2Text: TextLabels.ProfileButtonsStackView.favoritesNFTLabel,
                      button3Text: TextLabels.ProfileButtonsStackView.aboutDeveloperLabel,
                      counts: [myNFTCount, favouritesCount])
    }
}
