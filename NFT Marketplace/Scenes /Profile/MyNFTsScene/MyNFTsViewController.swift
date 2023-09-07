//
//  MyNFTsViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 05.09.2023.
//

import UIKit

final class MyNFTsViewController: UIViewController {

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
        navigationItem.title = "Мои NFT"

        let filterButton = UIBarButtonItem(image: UIImage(named: "filter_ikon"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton

        navigationController?.navigationBar.tintColor = .blackDayNight
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blackDayNight as Any
        ]

    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func filterButtonTapped() {}

}
