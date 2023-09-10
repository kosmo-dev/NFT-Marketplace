//
//  FavoritesNFTViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 06.09.2023.
//

import UIKit

final class FavoritesNFTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        
        setupNavigationBar()
        
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
        navigationItem.title = "Избранные NFT"

        navigationController?.navigationBar.tintColor = .blackDayNight
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blackDayNight as Any
        ]
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    

}
