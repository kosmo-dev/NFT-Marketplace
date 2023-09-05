//
//  PaymentConfirmationViewController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import UIKit

protocol PaymentConfirmationViewControllerProtocol: AnyObject {
    func configureElements(imageName: String, description: String, buttonText: String)
}

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
        descriptionTitle.textAlignment = .center
        descriptionTitle.textColor = .blackDayNight
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTitle
    }()

    private let button: CustomButton = {
        let button = CustomButton(type: .filled, title: "", action: #selector(buttonTapped))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var presenter: PaymentConfirmationPresenter

    // MARK: - Initiializers
    init(presenter: PaymentConfirmationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewController = self
        presenter.viewDidLoad()
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

// MARK: - PaymentConfirmationViewControllerProtocol
extension PaymentConfirmationViewController: PaymentConfirmationViewControllerProtocol {
    func configureElements(imageName: String, description: String, buttonText: String) {
        imageConfirmationView.image = UIImage(named: imageName)
        descriptionTitle.text = description
        button.setTitle(buttonText, for: .normal)
    }
}
