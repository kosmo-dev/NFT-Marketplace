//
//  CatalogueViewController.swift
//  NFT Marketplace
//
//  Created by Dzhami on 28.08.2023.
//

import UIKit
import Kingfisher

// MARK: - Protocol

protocol CatalogViewControllerProtocol: AnyObject {
    func reloadTableView()
}

// MARK: - Final Class

final class CatalogViewController: UIViewController, CatalogViewControllerProtocol {

    private var presenter: CatalogPresenterProtocol

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadNFTCollections), for: .valueChanged)
        return refreshControl
    }()

    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(named: "sort"),
            style: .plain,
            target: self,
            action: #selector(showSortingMenu))
        return button
    }()

    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(CatalogTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .whiteDayNight
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init(presenter: CatalogPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
        setupConstraints()
        presenter.viewController = self // Назначаем viewCotroller для презентера
        loadNFTCollections()
        view.backgroundColor = .whiteDayNight
    }

    // MARK: - Func
    
  
    private func setupNavigationBar() {
        sortButton.tintColor = .blackDayNight
        navigationController?.navigationBar.tintColor = .whiteDayNight
        navigationItem.rightBarButtonItem = sortButton
    }

    private func setupUI() {
        tableView.refreshControl = refreshControl
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

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    

    // MARK: - @objc func

    @objc func showSortingMenu() {
        let alertMenu = UIAlertController(title: TextLabels.CatalogVC.sorting, message: nil, preferredStyle: .actionSheet)

        alertMenu.addAction(UIAlertAction(title: TextLabels.CatalogVC.sortByName, style: .default, handler: { [weak self] (_) in
            self?.presenter.sortNFTS(by: .name)
            self?.reloadTableView()
        }))
        alertMenu.addAction(UIAlertAction(title: TextLabels.CatalogVC.sortByNFTCount, style: .default, handler: { [weak self] (_) in
            self?.presenter.sortNFTS(by: .nftCount)
            self?.reloadTableView()
        }))
        alertMenu.addAction(UIAlertAction(title: TextLabels.CatalogVC.close, style: .cancel))

        present(alertMenu, animated: true)
    }

    @objc func loadNFTCollections() {
        presenter.fetchCollections()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CatalogTableViewCell = tableView.dequeueReusableCell()
        let nftModel = presenter.dataSource[indexPath.row]
        let url = URL(string: nftModel.cover.encodeUrl)

        cell.selectionStyle = .none
        cell.cellImage.kf.setImage(with: url)
        cell.catalogNameLabel.text = "\(nftModel.name) \(nftModel.nftCount)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        187
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appConfig = AppConfiguration()
        let nftModel = presenter.dataSource[indexPath.row]
        let viewController = appConfig.assemblyCollectionScreen(with: nftModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
