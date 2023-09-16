//
//  CatalogСollectionViewController.swift
//  NFT Marketplace
//
//  Created by Dzhami on 01.09.2023.
//

import UIKit
import SafariServices
import ProgressHUD

// MARK: - Protocol

protocol CatalogСollectionViewControllerProtocol: AnyObject {
    func renderViewData(viewData: CatalogCollectionViewData)
    func reloadCollectionView()
}

// MARK: - Final Class

final class CatalogСollectionViewController: UIViewController {

    private var presenter: CatalogСollectionPresenterProtocol
    private var collectionViewHeightConstraint = NSLayoutConstraint()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var coverImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor =  .blackDayNight
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackDayNight
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextLabels.CollectionVC.aboutAuthor
        return label
    }()
    
    private lazy var authorLink: UILabel = {
        let label = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleWebsiteLabelTap))
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .blueUni
        label.backgroundColor = .whiteDayNight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .blackDayNight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nftCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.isScrollEnabled = false
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(NFTCollectionCell.self)
        return collection
    }()
    
    init(presenter: CatalogСollectionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        presenter.viewController = self
        setupConstraints()
        setupNavigationBackButton()
        view.backgroundColor = .whiteDayNight
        presenter.loadAuthorWebsite()
        presenter.loadNFTs()
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [coverImageView, titleLabel, authorLabel, authorLink, collectionDescriptionLabel, nftCollection].forEach {contentView.addSubview($0)}
        
        var topbarHeight: CGFloat {
            return (navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
        
        collectionViewHeightConstraint = nftCollection.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -topbarHeight),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coverImageView.heightAnchor.constraint(equalToConstant: 310),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            authorLink.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLink.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 4),
            authorLink.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            authorLink.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 1),
            
            collectionDescriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nftCollection.topAnchor.constraint(equalTo: collectionDescriptionLabel.bottomAnchor, constant: 24),
            nftCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nftCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionViewHeightConstraint
        ])
    }
    
    private func setupNavigationBackButton() {
        navigationController!.navigationBar.tintColor = .blackUni
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "backward"),
            style: .plain,
            target: self,
            action: #selector(goBack))
    }
    
    private func calculateCollectionHeight(itemCount: Int) {
        let itemsPerRow = 3
        let bottomMargin: CGFloat = 55
        let cellHeight: CGFloat = 172
        let numRows = (itemCount + itemsPerRow - 1) / itemsPerRow // Вычисляем количество строк
        
        // Вычисляем высоту коллекции
        collectionViewHeightConstraint.constant = CGFloat(numRows) * cellHeight + bottomMargin
    }
    
    // MARK: - @objc func
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleWebsiteLabelTap() {
        guard let url = URL(string: presenter.userURL ?? "")  else { return }
        let safaryVC = SFSafariViewController(url: url)
        setupNavigationBackButton()
        navigationController?.present(safaryVC, animated: true)
        navigationItem.backBarButtonItem =  UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CatalogСollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = presenter.nftArray.count
        calculateCollectionHeight(itemCount: itemCount)
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NFTCollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let data = presenter.nftArray[indexPath.row]
        cell.nftModel = data
        cell.delegate = self
        cell.configureCellWithModel()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 108, height: 172)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

// MARK: - NFTCollectionCellDelegate

extension CatalogСollectionViewController: NFTCollectionCellDelegate {
    func likeButtonDidTapped(nftModel: NFT) {
        presenter.handleLikeButtonPressed(model: nftModel)
    }
    
    
    func addToCardButtonDidTapped(nftModel: NFT) {
        presenter.handleCartButtonPressed(model: nftModel)
    }
}

// MARK: - CatalogСollectionViewControllerProtocol

extension CatalogСollectionViewController: CatalogСollectionViewControllerProtocol {
    
    func renderViewData(viewData: CatalogCollectionViewData) {
        DispatchQueue.main.async {
            self.loadCoverImage(url: viewData.coverImageURL)
            self.titleLabel.text = viewData.title
            self.authorLink.text = viewData.authorName
            self.collectionDescriptionLabel.text = viewData.description}
    }
    
    private func loadCoverImage(url : String) {
        let url = URL(string: url.encodeUrl)
        coverImageView.kf.setImage(with: url)
    }
    
    func reloadCollectionView() {
        nftCollection.reloadData()
    }
}
