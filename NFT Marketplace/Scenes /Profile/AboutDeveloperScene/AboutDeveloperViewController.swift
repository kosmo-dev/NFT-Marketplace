//
//  AboutDeveloperViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 06.09.2023.
//

import UIKit

final class AboutDeveloperViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let developerVadim = Developer(name: "Вадим Кузьмин", imageName: "profilePlaceholder", telegram: "@telegram", email: "1111@gmail.com", description: "Так и больше никак")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        setupNavigationBar()
    }

    // MARK: - Private Methods
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
        navigationItem.title = TextLabels.AboutDevelopersVC.navigationTitle

        navigationController?.navigationBar.tintColor = .blackDayNight
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blackDayNight as Any
        ]
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
