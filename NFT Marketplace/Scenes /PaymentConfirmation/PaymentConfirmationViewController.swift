//
//  PaymentConfirmationViewController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import UIKit

final class PaymentConfirmationViewController: UIViewController {
    // MARK: - Private Properties
    private let imageConfirmationView: UIImageView = {
        let imageConfirmationView = UIImageView()
        imageConfirmationView.translatesAutoresizingMaskIntoConstraints = false
        return imageConfirmationView
    }()

    private let descriptionTitle: UILabel = {
        let descriptionTitle = UILabel()
        descriptionTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        descriptionTitle.numberOfLines = 0
        descriptionTitle.textColor = .blackDayNight
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTitle
    }()

    private let button: CustomButton = {
        let button = CustomButton(type: .filled, title: "", action: #selector(buttonTapped))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }

    // MARK: - Public Methods
    func configure() {
        descriptionTitle.text = TextStrings.PaymentConfirmationViewController.paymentConfirmed
        button.setTitle(TextStrings.PaymentConfirmationViewController.returnButton, for: .normal)
        imageConfirmationView.image = UIImage(named: "PaymentSuccededImage")
    }

    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .whiteDayNight

        [imageConfirmationView, descriptionTitle, button].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            imageConfirmationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageConfirmationView.widthAnchor.constraint(equalTo: imageConfirmationView.heightAnchor),
            imageConfirmationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),

            descriptionTitle.topAnchor.constraint(equalTo: imageConfirmationView.bottomAnchor, constant: 20),
            descriptionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            descriptionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),

            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc private func buttonTapped() {

    }

}
