//
//  UsersCollectionViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 09.09.2023.
//

import UIKit

protocol UsersCollectionViewControllerProtocol: AnyObject {
    func reloadCollectionView()
    func updateCell(at index: Int)
}

final class UsersCollectionViewController: UIViewController, UsersCollectionViewControllerProtocol {

    private let presenter: UsersCollectionPresenterProtocol

    private let header: UILabel = {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.textColor = .blackDayNight
        header.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        header.text = TextLabels.UsersCollectionVC.headerTitle
        return header
    }()

    private lazy var backwardButton: UIButton = {
        let backwardButton = UIButton(type: .custom)
        backwardButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backwardButton.tintColor = .blackDayNight
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.addTarget(self, action: #selector(backwardTapped), for: .touchUpInside)
        return backwardButton
    }()

    private let NFTCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let NFTCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        NFTCollection.register(NFTCollectionCell.self, forCellWithReuseIdentifier: "NFTCollectionCell")
        NFTCollection.backgroundColor = .whiteDayNight
        NFTCollection.allowsMultipleSelection = false
        NFTCollection.showsVerticalScrollIndicator = false
        NFTCollection.translatesAutoresizingMaskIntoConstraints = false
        return NFTCollection
    }()

    init(presenter: UsersCollectionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .whiteDayNight
        addSubviews()
        setupConstraints()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backwardButton)

        NFTCollection.dataSource = self
        NFTCollection.delegate = self

        presenter.view = self
        presenter.loadNFTFromServer()
    }

    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.NFTCollection.reloadData()
        }
    }

    func updateCell(at index: Int) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = self.NFTCollection.cellForItem(at: indexPath) as? NFTCollectionCell {
                self.configureCell(cell, at: indexPath)
            }
        }
    }

    @objc private func backwardTapped() {
        dismiss(animated: true)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            backwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backwardButton.heightAnchor.constraint(equalToConstant: 24),
            backwardButton.widthAnchor.constraint(equalTo: backwardButton.heightAnchor),

            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: backwardButton.centerYAnchor),

            NFTCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            NFTCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            NFTCollection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 30),
            NFTCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func addSubviews() {
        view.addSubview(header)
        view.addSubview(backwardButton)
        view.addSubview(NFTCollection)
    }

    private func configureCell(_ cell: NFTCollectionCell, at indexPath: IndexPath) {
        guard let nft = presenter.nfts(at: indexPath.row) else { return }

        DispatchQueue.main.async {
            cell.delegate = self
            cell.nftModel = nft
            cell.nftName.text = nft.name
            cell.nftPrice.text = "\(nft.price) ETH"
            cell.nftImage.image = UIImage()
            cell.starRatingView.configureRating(nft.rating)

            if self.presenter.liked(id: nft.id) ?? false {
                cell.likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "noLike"), for: .normal)
            }

            if self.presenter.addedToCart(nft: nft) ?? false {
                cell.cartButton.setImage(UIImage(named: "removeFromCart"), for: .normal)
            } else {
                cell.cartButton.setImage(UIImage(named: "addToCart"), for: .normal)
            }

            if let firstImage = nft.images.first {
                self.presenter.loadNFTImage(imageView: cell.nftImage, url: firstImage)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension UsersCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.userNFTcount()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "NFTCollectionCell",
            for: indexPath
        ) as? NFTCollectionCell else {
            return UICollectionViewCell()
        }

        configureCell(cell, at: indexPath)
        cell.likeButton.tag = indexPath.row

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UsersCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 108, height: 172)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 9
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 28
    }
}

// MARK: - UICollectionViewDelegate
extension UsersCollectionViewController: UICollectionViewDelegate {

}

// MARK: - NFTCollectionCellDelegate
extension UsersCollectionViewController: NFTCollectionCellDelegate {
    func likeButtonDidTapped(cell: NFTCollectionCell) {
        self.presenter.tapLike(cell)
    }

    func addToCardButtonDidTapped(cell: NFTCollectionCell) {
        self.presenter.cartButtonTapped(cell: cell)
    }
}
