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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        setupNavigationBar()
        setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: false)
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

    private func setupLayout() {
        stackView.axis = .vertical
        stackView.spacing = 16

        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        let developers: [Developer] = [
            DevelopersData.vadimData, DevelopersData.ritaData, DevelopersData.dzamiData, DevelopersData.denisData
        ]

        for developer in developers {
            let developerView = DeveloperCustomView(developer: developer)
            stackView.addArrangedSubview(developerView)
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
