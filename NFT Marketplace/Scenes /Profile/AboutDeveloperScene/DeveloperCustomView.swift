//
//  DeveloperCustomView.swift
//  NFT Marketplace
//
//  Created by Денис on 16.09.2023.
//

import UIKit

struct Developer {
    let name: String
    let imageName: String
    let telegram: String
    let email: String
    let description: String
}

final class DeveloperCustomView: UIView {

    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя: "
        label.numberOfLines = 2
        return label
    }()

    private lazy var telegramLabel: UILabel = {
        let label = UILabel()
        label.text = "Telegram: "
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(telegramTapped))
        label.addGestureRecognizer(tap)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail: "
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(emailTapped))
        label.addGestureRecognizer(tap)
        return label
    }()

    private lazy var contactStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, telegramLabel, emailLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    override init(frame: CGRect) {
//        super.init(frame: .zero)
////        addSubview(imageView)
////        addSubview(contactStackView)
////        addSubview(descriptionLabel)
//        setupLayout()
//    }

    init(developer: Developer) {
        super.init(frame: .zero)
        configure(with: developer)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        self.addSubview(imageView)
        self.addSubview(contactStackView)
        self.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            contactStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            contactStackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            contactStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }

    func configure(with developer: Developer) {
        imageView.image = UIImage(named: developer.imageName)
        nameLabel.text = "Имя: \n\(developer.name)"
        telegramLabel.text = "Telegram: \n\(developer.telegram)"
        emailLabel.text = "E-mail: \n\(developer.email)"
        descriptionLabel.text = "\(developer.description)"
    }

    @objc func telegramTapped() {

    }

    @objc func emailTapped() {

    }
}
