//
//  UserProfileStackView.swift
//  NFT Marketplace
//
//  Created by Денис on 27.08.2023.
//

import UIKit
import Kingfisher

final class UserProfileStackView: UIView {
    
    //MARK: - Computered Properties
    
    let avatarImage: UIImageView = {
       let imageView = UIImageView()
//        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Profile_Placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.text = "Имя Пользователя"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let userInfoText: UILabel = {
        let userInfo = UILabel()
        userInfo.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        userInfo.text = "Это информация о пользователе. Здесь может быть его биография, интересы или другая полезная информация."
        userInfo.textAlignment = .left
        userInfo.numberOfLines = 0
        userInfo.translatesAutoresizingMaskIntoConstraints = false
        
        return userInfo
    }()
    
    let websiteLabel: UILabel = {
       let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textColor = .blueUni
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var onImageLoaded: ((UIImage) -> Void)?
    
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
        let horizontalStack = UIStackView(arrangedSubviews: [avatarImage, nameLabel])
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
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserWebsite))
        websiteLabel.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func tapUserWebsite() {
        if let websiteURL = URL(string: websiteLabel.text ?? "") {
            UIApplication.shared.open(websiteURL)
        }
    }
}

extension UserProfileStackView {
    func update(with profile: UserProfile) {
        nameLabel.text = profile.name
        userInfoText.text = profile.description
        websiteLabel.text = profile.website
        
        if let url = URL(string: profile.avatar) {
            avatarImage.kf.setImage(with: url, placeholder: UIImage(named: "Profile_Placeholder")) { [weak self] result in
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
}





//let cache = ImageCache.default
//cache.retrieveImage(forKey: "userAvatarImage", options: nil) { [weak self] result in
//    switch result {
//    case .success(let cacheResult):
//        if let cachedImage = cacheResult.image {
//            // Если изображение найдено в кэше (в памяти или на диске)
//            self?.avatarImage.image = cachedImage
//            self?.onImageLoaded?(cachedImage)
//        }
//    case .failure:
//        if let url = URL(string: profile.avatar) {
//            self?.avatarImage.kf.setImage(with: url, placeholder: UIImage(named: "Profile_Placeholder")) { result in
//                switch result {
//                case .success(let value):
//                    print("Image: \(value.image). Got from: \(value.cacheType)")
//                    self?.onImageLoaded?(value.image)
//                    if value.cacheType == .none { // если изображение не из кэша, сохраняем его в кэше
//                        cache.store(value.image, forKey: "userAvatarImage")
//                    }
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        }
//    }
//}

//if let url = URL(string: profile.avatar) {
//    avatarImage.kf.setImage(with: url, placeholder: UIImage(named: "Profile_Placeholder")) { result in
//        switch result {
//        case .success(let value):
//            print("Image: \(value.image). Got from: \(value.cacheType)")
//
//        case .failure(let error):
//            print("Error: \(error)")
//        }
//    }
//}
