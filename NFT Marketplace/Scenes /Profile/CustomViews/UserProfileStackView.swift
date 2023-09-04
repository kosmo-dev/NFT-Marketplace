//
//  UserProfileStackView.swift
//  NFT Marketplace
//
//  Created by Денис on 27.08.2023.
//

import UIKit
import Kingfisher

protocol UserProfileStackViewDelegate: AnyObject {
    func userProfileStackViewDidTapWebsite(_ stackView: UserProfileStackView, url: URL)
}

final class UserProfileStackView: UIView {
    
    //MARK: - Computered Properties
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Profile_Placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.text = S.UserProfileStackView.userNameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let userInfoText: UILabel = {
        let userInfo = UILabel()
        userInfo.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        userInfo.text = S.UserProfileStackView.userInfoLabel
        userInfo.textAlignment = .left
        userInfo.numberOfLines = 0
        userInfo.translatesAutoresizingMaskIntoConstraints = false
        
        return userInfo
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = S.UserProfileStackView.websiteLabel
        label.textColor = .blueUni
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var onImageLoaded: ((UIImage) -> Void)?
    weak var delegate: UserProfileStackViewDelegate?
    
    //MARK: - Initiliazers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        //Задаю стэк "Ава + Имя"
        let horizontalStack = UIStackView(arrangedSubviews: [avatarImageView, nameLabel])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 10
        
        let verticalStack = UIStackView(arrangedSubviews: [horizontalStack, userInfoText, websiteLabel])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.spacing = 10
        verticalStack.alignment = .top
        
        
        addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserWebsite))
        websiteLabel.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func tapUserWebsite() {
        if let websiteString = websiteLabel.text, let websiteURL = URL(string: websiteString) {
            delegate?.userProfileStackViewDidTapWebsite(self, url: websiteURL)
        }
    }
}

//MARK: - Метод для обновления данных при переходе на ProfileViewController
extension UserProfileStackView {
    func update(with profile: UserProfile) {
        nameLabel.text = profile.name
        userInfoText.text = profile.description
        websiteLabel.text = profile.website
        
        ImageCache.default.retrieveImage(forKey: "userAvatarImage", options: nil) { [weak self] result in
            switch result {
            case .success(let cacheResult):
                if let cachedImage = cacheResult.image {
                    self?.avatarImageView.image = cachedImage
                    self?.onImageLoaded?(cachedImage)
                } else {
                    if let url = URL(string: profile.avatar) {
                        self?.avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "Profile_Placeholder")) { result in
                            switch result {
                            case .success(let value):
                                print("Image: \(value.image). Got from: \(value.cacheType)")
                                self?.onImageLoaded?(value.image)
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Error retrieving from cache: \(error)")
                // Здесь можно добавить дополнительную логику, если что-то пойдет не так с кэшем.
            }
        }
    }
}


extension UserProfileStackView {
    func updateAvatarImage(_ newImage: UIImage) {
        avatarImageView.image = newImage
    }
}
