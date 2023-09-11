//
//  UsersCollectionViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 09.09.2023.
//

import UIKit

protocol UsersCollectionViewControllerProtocol: AnyObject {
    func reloadCollectionView()
}

final class UsersCollectionViewController: UIViewController, UsersCollectionViewControllerProtocol {

    var presenter: UsersCollectionPresenterProtocol?

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
        backwardButton.setImage(UIImage(named: "Backward"), for: .normal)
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.addTarget(self, action: #selector(backwardTapped), for: .touchUpInside)
        return backwardButton
    }()

    private let NFTCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let NFTCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        NFTCollection.register(NFTCollectionCell.self, forCellWithReuseIdentifier: "NFTCollectionCell")
        NFTCollection.allowsMultipleSelection = false
        NFTCollection.translatesAutoresizingMaskIntoConstraints = false
        return NFTCollection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backwardButton)

        NFTCollection.dataSource = self
        NFTCollection.delegate = self
    }

    func reloadCollectionView() {
        NFTCollection.reloadData()
    }

    @objc private func backwardTapped() {
        dismiss(animated: true)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            backwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backwardButton.heightAnchor.constraint(equalToConstant: 24),

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
}

// MARK: - UICollectionViewDataSource
extension UsersCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.userNFTcount() ?? 0
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

        // настройка ячейки

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
