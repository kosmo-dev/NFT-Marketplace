//
//  FavoritesNFTCVCell.swift
//  NFT Marketplace
//
//  Created by Денис on 10.09.2023.
//

import UIKit
import Kingfisher

protocol FavoritesNFTCVCellDelegate: AnyObject {
    func didTapLikeButton(in cell: FavoritesNFTCVCell)
}

final class FavoritesNFTCVCell: UICollectionViewCell {

    weak var delegate: FavoritesNFTCVCellDelegate?

    // MARK: - Private Properties
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profilePlaceholder")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return nameLabel
    }()

    private lazy var ratingView: StarRatingView = {
       let starRating = StarRatingView()

        return starRating
    }()

    private lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        return formatter
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "likeImage"), for: .normal)
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [nameLabel, ratingView, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [imageView, stackView, likeButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 68),
            ratingView.heightAnchor.constraint(equalToConstant: 12),

            likeButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -5),
            likeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            likeButton.widthAnchor.constraint(equalToConstant: 42),
            likeButton.heightAnchor.constraint(equalToConstant: 42)

        ])
    }

    @objc func didTapLikeButton() {
        print("Нажатие на кнопку")
        delegate?.didTapLikeButton(in: self)
    }

    func setLiked(_ isLiked: Bool) {
        let imageName = isLiked ? "likeImage" : "noLikeImage"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }

    func configure(with nft: NFTModel) {
        nameLabel.text = nft.name
        ratingView.configureRating(nft.rating)

        if let formatterPrice = numberFormatter.string(from: NSNumber(value: nft.price)) {
            priceLabel.text = formatterPrice + " " + "ETH"
        } else {
            priceLabel.text = "\(nft.price)" + " " + "ETH"
        }

        if let imageURL = nft.images.first, let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "profilePlaceholder")
        }
    }
}
