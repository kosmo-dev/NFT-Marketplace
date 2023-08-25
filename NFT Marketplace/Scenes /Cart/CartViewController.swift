//
//  CartViewController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

final class CartViewController: UIViewController {
    // MARK: - Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .whiteDayNight
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let nfts = [
        NFT(name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"], rating: 5, description: "", price: 1, author: "", id: "1", createdAt: ""),
        NFT(name: "Aurora", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"], rating: 4, description: "", price: 1.5, author: "", id: "2", createdAt: ""),
        NFT(name: "Bimbo", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"], rating: 3, description: "", price: 2, author: "", id: "3", createdAt: ""),
        NFT(name: "Biscuit", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Biscuit/1.png"], rating: 4, description: "", price: 2.5, author: "", id: "4", createdAt: ""),
        NFT(name: "Breena", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Breena/1.png"], rating: 1, description: "", price: 3, author: "", id: "5", createdAt: ""),
        NFT(name: "Buster", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Buster/1.png"], rating: 3, description: "", price: 3.5, author: "", id: "6", createdAt: ""),
        NFT(name: "Corbin", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Corbin/1.png"], rating: 0, description: "", price: 4, author: "", id: "7", createdAt: ""),
        NFT(name: "Cupid", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Cupid/1.png"], rating: 5, description: "", price: 4.55, author: "", id: "8", createdAt: "")
    ]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        tableView.register(CartNFTCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteDayNight
        [tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nfts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartNFTCell = tableView.dequeueReusableCell()
        let nft = nfts[indexPath.row]
        let cellViewModel = CartCellViewModel(imageURL: nft.images[0], title: nft.name, price: "\(nft.price) ETH", rating: nft.rating)
        cell.configureCell(cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
