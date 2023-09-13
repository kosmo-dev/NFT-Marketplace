//
//  NFTCollectionCell.swift
//  NFT Marketplace
//
//  Created by Dzhami on 02.09.2023.
//

import UIKit
// MARK: - Protocol

protocol NFTCollectionCellDelegate: AnyObject {
    func likeButtonDidTapped(cell: NFTCollectionCell)
    func addToCardButtonDidTapped(cell: NFTCollectionCell)
}

// MARK: - Final Class

final class NFTCollectionCell: UICollectionViewCell, ReuseIdentifying {

    weak var delegate: NFTCollectionCellDelegate?

    var nftId: String?

    lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "NFT_card")
        return imageView
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeIcon"), for: .normal)
        button.imageView?.tintColor = .redUni
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addToCart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        return button
    }()

    lazy var starRatingView: StarRatingView = {
        let view = StarRatingView()
        view.configureRating(4)
        return view
    }()

    private lazy var nftNameAndPriceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var nftName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nftName"
        label.font = UIFont.bodyBold
        return label
    }()

    lazy var nftPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 ETH"
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configCell() {
        starRatingView.translatesAutoresizingMaskIntoConstraints = false

        [nftImage, likeButton, starRatingView, cartButton, nftNameAndPriceView].forEach {contentView.addSubview($0)}
        [nftName, nftPrice].forEach {nftNameAndPriceView.addSubview($0)}

        NSLayoutConstraint.activate([

            // ImageView
            nftImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImage.heightAnchor.constraint(equalToConstant: 108),

            // LikeButton
            likeButton.topAnchor.constraint(equalTo: nftImage.topAnchor, constant: 12),
            likeButton.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: -12),
            likeButton.widthAnchor.constraint(equalToConstant: 26),
            likeButton.heightAnchor.constraint(equalToConstant: 22),

            // starRatingView
            starRatingView.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 8),
            starRatingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            starRatingView.widthAnchor.constraint(equalToConstant: 70),

            nftNameAndPriceView.topAnchor.constraint(equalTo: starRatingView.bottomAnchor, constant: 4),
            nftNameAndPriceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftNameAndPriceView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.63),
            nftNameAndPriceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // NFT_Name
            nftName.topAnchor.constraint(equalTo: nftNameAndPriceView.topAnchor),
            nftName.leadingAnchor.constraint(equalTo: nftNameAndPriceView.leadingAnchor),
            nftName.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndPriceView.trailingAnchor),

            // NFTPrice
            nftPrice.bottomAnchor.constraint(equalTo: nftNameAndPriceView.bottomAnchor),
            nftPrice.leadingAnchor.constraint(equalTo: nftNameAndPriceView.leadingAnchor),
            nftPrice.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndPriceView.trailingAnchor),

            // Cart
            cartButton.centerYAnchor.constraint(equalTo: nftNameAndPriceView.centerYAnchor),
            cartButton.leadingAnchor.constraint(greaterThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    // MARK: - @objc func

    @objc func didTapLike() {
        print(self.nftId)
        delegate?.likeButtonDidTapped(cell: self)
    }

    @objc func didTapCart() {
        delegate?.addToCardButtonDidTapped(cell: self)
    }
}
