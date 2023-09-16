//
//  MyNFTsViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 05.09.2023.
//

import UIKit

protocol MyNFTsViewProtocol: AnyObject {
    func updateWith(nfts: [NFTModel])
    func showError(_ error: Error)
}

final class MyNFTsViewController: UIViewController {

    // MARK: - Private Properties

    private var placeholderLabel: UILabel = {
       let label = UILabel()
        label.text = "У Вас еще нет NFT"
        label.textColor = .blackDayNight
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var tableView: UITableView!
    private var presenter: MyNFTsPresenter?
    private var nftModels: [NFTModel] = []
    private var nftIds: [String]
    private var likedNFTIds: [String]

    init(nftIds: [String], likedNFTIds: [String]) {
        self.nftIds = nftIds
        self.likedNFTIds = likedNFTIds
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        setupPresenter()
        setupNavigationBar()
        setupTableView()
        print("NFT - \(nftIds.count) (\(nftIds)), Лайки - \(likedNFTIds.count)(\(likedNFTIds))")

    }

    // MARK: - Private Methods
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
        navigationItem.title = TextLabels.MyNFTsVC.navigationTitle

        let filterButton = UIBarButtonItem(image: UIImage(named: "filterIcon"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton

        navigationController?.navigationBar.tintColor = .blackDayNight
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blackDayNight as Any
        ]

    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NFTTableViewCell.self, forCellReuseIdentifier: "NFTTableViewCell")
        view.addSubview(tableView)
        view.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func filterButtonTapped() {
        let alertController = UIAlertController(title: nil,
                                                message: TextLabels.MyNFTsVC.alertTitleLabel,
                                                preferredStyle: .actionSheet)

        let sortByPriceAction = UIAlertAction(title: TextLabels.MyNFTsVC.alertPriceLabel,
                                              style: .default) { _ in
            self.presenter?.sortNFTs(by: .price)
        }
        let sortByRatingAction = UIAlertAction(title: TextLabels.MyNFTsVC.alertRatingLabel,
                                               style: .default) { _ in
            self.presenter?.sortNFTs(by: .rating)
        }
        let sortByNameAction = UIAlertAction(title: TextLabels.MyNFTsVC.alertNameLabel,
                                             style: .default) { _ in
            self.presenter?.sortNFTs(by: .name)
        }
        let cancelAction = UIAlertAction(title: TextLabels.MyNFTsVC.alertCloseLabel,
                                         style: .cancel, handler: nil)

        [sortByPriceAction, sortByRatingAction, sortByNameAction, cancelAction].forEach {
            alertController.addAction($0)
        }

        present(alertController, animated: true, completion: nil)
    }
}

extension MyNFTsViewController: MyNFTsViewProtocol {

    func setupPresenter() {
        let profileService = ProfileService()
        presenter = MyNFTsPresenter(nftIds: self.nftIds, likedNFTIds: self.likedNFTIds, profileService: profileService)
        presenter?.view = self
        presenter?.viewDidLoad()
    }

    func updateWith(nfts: [NFTModel]) {
        self.nftModels = nfts
        DispatchQueue.main.async {
            if self.nftModels.isEmpty {
                self.placeholderLabel.isHidden = false
            } else {
                self.placeholderLabel.isHidden = true
            }
            self.tableView.reloadData()
        }
    }

    func showError(_ error: Error) {
        print("Fetching error: \(error.localizedDescription)")
    }

}

extension MyNFTsViewController: NFTTableViewCellDelegate {
    func didToogleLike(forNFTWithId id: String) {
        print("Toggled like for NFT with id: \(id)")
        presenter?.toogleLike(forNFTWithId: id)

        if let index = self.presenter?.nftModels.firstIndex(where: { $0.id == id }) {
            let indexPath = IndexPath(row: index, section: 0)

            // Обновляем конкретную ячейку
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension MyNFTsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.nftModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NFTTableViewCell",
            for: indexPath) as? NFTTableViewCell
        let nft = presenter?.nftModels[indexPath.row]

        cell?.delegate = self
        cell?.configure(with: nft!)

        let isLiked = presenter?.isLiked(nftId: nft!.id) ?? false
        cell?.configurateLikeButton(isLiked: isLiked)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
