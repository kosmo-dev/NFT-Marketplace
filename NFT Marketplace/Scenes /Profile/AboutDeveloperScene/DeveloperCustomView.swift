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
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
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
        stack.spacing = 10
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

    private var developer: Developer?

    init(developer: Developer) {
        super.init(frame: .zero)
        self.developer = developer
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
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            contactStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
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
        nameLabel.text = "\(developer.name)"
        setupTelegramLabel(with: developer.telegram)
        setupMailLabel(with: developer.email)
        descriptionLabel.text = "\(developer.description)"
    }

    func setupTelegramLabel(with text: String) {
        let telegramAttachment = NSTextAttachment()
        if let telegramImage = UIImage(systemName: "paperplane.fill") {
            telegramAttachment.image = telegramImage.withRenderingMode(.alwaysTemplate).withTintColor(.blackDayNight)
        }
        let telegramIcon = NSAttributedString(attachment: telegramAttachment)

        let telegramText = NSMutableAttributedString(string: "Telegram: \n\(text) ")
        telegramText.append(telegramIcon)
        telegramLabel.attributedText = telegramText
    }

    func setupMailLabel(with text: String) {
        let emailAttachment = NSTextAttachment()
            if let emailImage = UIImage(systemName: "envelope.fill") {
                emailAttachment.image = emailImage.withRenderingMode(.alwaysTemplate).withTintColor(.blackDayNight)
            }

            let emailIcon = NSAttributedString(attachment: emailAttachment)

            let emailText = NSMutableAttributedString(string: "E-mail: \n\(text) ")
            emailText.append(emailIcon)

            emailLabel.attributedText = emailText
    }

    @objc func telegramTapped() {
        guard let developer = self.developer else { return }
        if let url = URL(string: "tg://resolve?domain=\(developer.telegram)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                if let webURL = URL(string: "https://t.me/\(developer.telegram)") {
                    UIApplication.shared.open(webURL)
                }
            }
        }
    }

    @objc func emailTapped() {
        guard let developer = self.developer else { return }

        if let url = URL(string: "mailto:\(developer.email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
