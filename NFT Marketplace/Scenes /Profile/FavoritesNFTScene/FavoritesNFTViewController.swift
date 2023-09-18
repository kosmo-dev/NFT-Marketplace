//
//  FavoritesNFTViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 06.09.2023.
//

import UIKit

protocol FavoritesNFTView: AnyObject {
    func updateNFTs(_ nfts: [NFTModel])
    func showError(_ error: Error)
}

final class FavoritesNFTViewController: UIViewController {

    // MARK: - Private Methods

    private struct LayoutConstants {
        static let horizontalPadding: CGFloat = 16
        static let numberOfColumns: CGFloat = 2
        static let interItemSpacing: CGFloat = 7
        static let lineSpacing: CGFloat = 20
    }

    private var collectionViewLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let totalHorizontalPadding: CGFloat = LayoutConstants.horizontalPadding * LayoutConstants.numberOfColumns + LayoutConstants.interItemSpacing
        let itemWidth: CGFloat = (view.frame.width - totalHorizontalPadding) / LayoutConstants.numberOfColumns
        layout.itemSize = CGSize(width: itemWidth, height: 80)

        layout.minimumLineSpacing = LayoutConstants.lineSpacing
        layout.minimumInteritemSpacing = LayoutConstants.interItemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: LayoutConstants.horizontalPadding,
                                           bottom: 0,
                                           right: LayoutConstants.horizontalPadding)
        return layout
    }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .whiteDayNight
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoritesNFTCVCell.self, forCellWithReuseIdentifier: "FavoriteNFTCell")
        return collectionView
    }()

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "У Вас еще нет избранных NFT"
        label.numberOfLines = 0
        label.textColor = .blackDayNight
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var presenter: FavoritesNFTPresenter?
    private var likedNFTs: [NFTModel] = []
    private var likedNFTIds: [String]

    init(likedNFTIds: [String]) {
        self.likedNFTIds = likedNFTIds
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight

        setupNavigationBar()
        setupPresenter()
        setupCollectionView()

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

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setupPresenter() {
        let profileService = ProfileService()
        presenter = FavoritesNFTPresenter(likedNFTIds: likedNFTIds, profileService: profileService)
        presenter?.view = self
        presenter?.viewDidLoad()
    }
}

extension FavoritesNFTViewController: FavoritesNFTCVCellDelegate {
    func didTapLikeButton(in cell: FavoritesNFTCVCell) {
        print("didTapLikeButton вызван")
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let nft = likedNFTs[indexPath.row]
        presenter?.toggleLikeStatus(for: nft)
        collectionView.deleteItems(at: [indexPath])
    }
}

extension FavoritesNFTViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.likedNFTs.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteNFTCell",
                                                      for: indexPath) as? FavoritesNFTCVCell
        let nft = likedNFTs[indexPath.row]
        cell?.configure(with: nft)
        cell?.delegate = self
        cell?.setLiked(likedNFTIds.contains(nft.id))
        return cell ?? UICollectionViewCell()
    }
}

extension FavoritesNFTViewController: FavoritesNFTView {
    func updateNFTs(_ nfts: [NFTModel]) {
        self.likedNFTs = nfts

        DispatchQueue.main.async {
            if self.likedNFTs.isEmpty {
                self.placeholderLabel.isHidden = false
            } else {
                self.placeholderLabel.isHidden = true
            }
            print("Обновление NFTs с \(nfts.count) элементами.")
            self.collectionView.reloadData()
        }
    }

    func showError(_ error: Error) {
        return
    }

}
