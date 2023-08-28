//
//  CatalogueViewController.swift
//  NFT Marketplace
//
//  Created by Dzhami on 28.08.2023.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadNFTCollections), for: .valueChanged)
        return refreshControl
    }()
    
    lazy private var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(named: "sort"),
            style: .plain,
            target: self,
            action: #selector(showSortingMenu))
        return button
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .whiteDayNight
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupConstraints()
        view.backgroundColor = .whiteDayNight
    }
    
    private func setupNavigationBar() {
        sortButton.tintColor = .blackDayNight
        navigationController?.navigationBar.tintColor = .whiteDayNight
        navigationItem.rightBarButtonItem = sortButton
    }
    
    
    private func setupConstraints() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: -  @objc func
    
    @objc func showSortingMenu() {
        
        let alertMenu = UIAlertController(title: S.CatalogVC.sorting, message: nil, preferredStyle: .actionSheet)
        
        alertMenu.addAction(UIAlertAction(title: S.CatalogVC.sortByName, style: .default, handler: { [weak self] (UIAlertAction) in
//            self.
        }))
        alertMenu.addAction(UIAlertAction(title: S.CatalogVC.sortByNFTCount, style: .default, handler: { [weak self] (UIAlertAction) in
//            self.
        }))
        alertMenu.addAction(UIAlertAction(title: S.CatalogVC.close, style: .cancel))
        
        present(alertMenu, animated: true)
    }
    
    @objc func loadNFTCollections() {
        
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.reuseIdentifier, for: indexPath) as? CatalogTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        187
    }
}
