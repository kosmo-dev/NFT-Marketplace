//
//  DeleteNFTView.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 31.08.2023.
//

import UIKit
import Kingfisher

protocol DeleteNFTViewDelegate: AnyObject {
    func deleteButtonTapped()
    func returnButtonTapped()
}

final class DeleteNFTView: UIView {
    weak var delegate: DeleteNFTViewDelegate?

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
        title.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        title.textColor = .blackDayNight
        title.numberOfLines = 2
        title.textAlignment = .center
        title.text = TextLabels.CartViewController.deleteFromCartTitle
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let deleteButton: CustomButton = {
        let deleteButton = CustomButton(
            type: .filled,
            title: TextLabels.CartViewController.deleteButton,
            action: #selector(deleteButtonTapped))
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        deleteButton.layer.cornerRadius = 12
        deleteButton.setTitleColor(.redUni, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()

    private let returnButton: CustomButton = {
        let returnButton = CustomButton(
            type: .filled,
            title: TextLabels.CartViewController.returnButton,
            action: #selector(returnButtonTapped))
        returnButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        returnButton.layer.cornerRadius = 12
        returnButton.setTitleColor(.whiteDayNight, for: .normal)
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        return returnButton
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var returnHandler: ((Bool) -> Void)?

    init() {
        super.init(frame: .zero)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(_ imageURL: String) {
        let url = URL(string: imageURL)
        nftImage.kf.setImage(with: url)
    }

    func setReturnHandler(_ handler: ((Bool) -> Void)?) {
        returnHandler = handler
    }

    private func configureView() {
        [deleteButton, returnButton].forEach { stackView.addArrangedSubview($0) }
        [nftImage, title, stackView].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            nftImage.topAnchor.constraint(equalTo: topAnchor),
            nftImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 77),
            nftImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -77),
            nftImage.heightAnchor.constraint(equalToConstant: 108),
            nftImage.widthAnchor.constraint(equalTo: nftImage.heightAnchor),

            title.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 41),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -41),

            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            deleteButton.widthAnchor.constraint(equalTo: returnButton.widthAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func deleteButtonTapped() {
        delegate?.deleteButtonTapped()
    }

    @objc private func returnButtonTapped() {
        delegate?.returnButtonTapped()
        if let returnHandler {
            returnHandler(true)
        }
    }
}
