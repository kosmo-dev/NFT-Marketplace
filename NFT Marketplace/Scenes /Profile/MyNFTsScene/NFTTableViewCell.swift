//
//  NFTTableViewCell.swift
//  NFT Marketplace
//
//  Created by Денис on 07.09.2023.
//

import UIKit
import Kingfisher

final class NFTTableViewCell: UITableViewCell {

    // MARK: - Private Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profilePlaceholder")
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "noLikeImage"), for: .normal)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        return label
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Имя"
        return label
    }()

    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "111.00"
        return label
    }()

    private lazy var starRatingView: StarRatingView = {
        let view = StarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupViews() {
        contentView.backgroundColor = .whiteDayNight
        contentView.addSubview(containerView)
        contentView.addSubview(nftImageView)
        contentView.addSubview(likeButton)

        let leftStack = UIStackView(arrangedSubviews: [titleLabel, starRatingView, authorLabel])
        leftStack.axis = .vertical
        leftStack.spacing = 4
        leftStack.translatesAutoresizingMaskIntoConstraints = false

        let rightStack = UIStackView(arrangedSubviews: [priceTitleLabel, priceLabel])
        rightStack.axis = .vertical
        rightStack.spacing = 4
        rightStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(leftStack)
        contentView.addSubview(rightStack)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            nftImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nftImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),

            likeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),

            leftStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            leftStack.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),

            rightStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rightStack.leadingAnchor.constraint(equalTo: leftStack.trailingAnchor, constant: 39)
        ])
    }

    func configure(with nft: NFTModel) {
        titleLabel.text = nft.name
        starRatingView.configureRating(nft.rating)
        authorLabel.text = nft.author
        priceLabel.text = "\(nft.price)" + " " + "ETH"

        if let imageURL = nft.images.first, let url = URL(string: imageURL) {
            nftImageView.kf.setImage(with: url)
        } else {
            nftImageView.image = UIImage(named: "profilePlaceholder")
        }
    }
}
