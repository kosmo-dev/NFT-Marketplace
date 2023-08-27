//
//  UserProfileStackView.swift
//  NFT Marketplace
//
//  Created by Денис on 27.08.2023.
//

import UIKit

final class UserProfileStackView: UIView {
    
    //MARK: - Computered Properties
    
    let avatarImage: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return nameLabel
    }()
    
    let userInfoTextView: UITextView = {
       let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    
    let websiteLabel: UILabel = {
       let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textColor = .blueUni
        return label
    }()
    
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
        
        let verticalStack = UIStackView(arrangedSubviews: [horizontalStack, userInfoTextView, websiteLabel])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.spacing = 10
        
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
