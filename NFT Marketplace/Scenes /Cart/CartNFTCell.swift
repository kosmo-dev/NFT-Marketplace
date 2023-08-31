//
//  CartNFTCell.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 25.08.2023.
//

import UIKit
import Kingfisher

protocol CartNFTCellDelegate: AnyObject {
    func deleteNFTButtonDidTapped(id: String, image: UIImage)
}

final class CartNFTCell: UITableViewCell, ReuseIdentifying {
    weak var delegate: CartNFTCellDelegate?

    // MARK: - Private Properties
    private let nftImage: UIImageView = {
        let nftImage = UIImageView()
        nftImage.layer.cornerRadius = 12
        nftImage.layer.masksToBounds = true
        nftImage.contentMode = .scaleAspectFill
        nftImage.translatesAutoresizingMaskIntoConstraints = false
        return nftImage
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = .blackDayNight
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let priceDescription: UILabel = {
        let priceDescription = UILabel()
        priceDescription.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        priceDescription.textColor = .blackDayNight
        priceDescription.text = TextStrings.CartNFTCell.priceDescription
        priceDescription.translatesAutoresizingMaskIntoConstraints = false
        return priceDescription
    }()

    private let price: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        price.textColor = .blackDayNight
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()

    private let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage.cartDeleteIcon, for: .normal)
        deleteButton.tintColor = .blackDayNight
        deleteButton.contentMode = .scaleAspectFit
        deleteButton.addTarget(nil, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()

    private let ratingView: StarRatingView = {
        let ratingView = StarRatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()

    private var cellId: String?
    private var indexPath: IndexPath?

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configureCell(_ cartCellViewModel: CartCellViewModel) {
        let imageURL = URL(string: cartCellViewModel.imageURL)
        nftImage.kf.setImage(with: imageURL)
        title.text = cartCellViewModel.title
        price.text = cartCellViewModel.price
        ratingView.configureRating(cartCellViewModel.rating)
        cellId = cartCellViewModel.id
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nftImage.kf.cancelDownloadTask()
    }

    // MARK: - Private Methods
    private func configureView() {
        [nftImage, title, ratingView, priceDescription, price, deleteButton].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            nftImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nftImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            nftImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nftImage.widthAnchor.constraint(equalTo: nftImage.heightAnchor, multiplier: 1),

            title.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            title.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 20),

            ratingView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            ratingView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 68),

            priceDescription.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 12),
            priceDescription.leadingAnchor.constraint(equalTo: title.leadingAnchor),

            price.topAnchor.constraint(equalTo: priceDescription.bottomAnchor, constant: 2),
            price.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            price.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),

            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }

    @objc private func deleteButtonTapped() {
        let image = nftImage.image ?? UIImage()
        guard let cellId else { return }
        delegate?.deleteNFTButtonDidTapped(id: cellId, image: image)
    }
}
