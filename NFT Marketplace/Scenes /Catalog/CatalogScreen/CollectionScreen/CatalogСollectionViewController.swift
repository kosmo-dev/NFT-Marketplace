//
//  CatalogСollectionViewController.swift
//  NFT Marketplace
//
//  Created by Dzhami on 01.09.2023.
//

import UIKit

final class CatalogСollectionViewController: UIViewController {
    
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
        image.image = UIImage(named: "collectionMockImage")
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor =  .blackDayNight
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Peach"
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackDayNight
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = S.CollectionVC.aboutAuthor
        return label
    }()
    
    private lazy var authorLink: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        textView.dataDetectorTypes = .link
        textView.textContainer.lineFragmentPadding = 0
        textView.delegate = self
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 13, weight: .light)
        textView.textColor = .blueUni
        textView.backgroundColor = .whiteDayNight
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Mock Link"
        return textView
    }()
    
    private lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .blackDayNight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей."
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
    
    override func viewDidLoad() {
        setupConstraints()
        setupNavigationBackButton()
        view.backgroundColor = .whiteDayNight
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
        let bottomMargin: CGFloat = 25
        let cellHeight: CGFloat = 172
        
        // Вычисляем количество строк
        let numRows = (itemCount + itemsPerRow - 1) / itemsPerRow
        
        // Вычисляем высоту коллекции
        collectionViewHeightConstraint.constant = CGFloat(numRows) * cellHeight + bottomMargin
    }
    
    // MARK: - @objc func
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}



// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CatalogСollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = 11
        calculateCollectionHeight(itemCount: itemCount)
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NFTCollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.nftName.text = "NFT1"
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

// MARK: - UITextViewDelegate
extension CatalogСollectionViewController: UITextViewDelegate {
    //    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    //
    //    }
}
