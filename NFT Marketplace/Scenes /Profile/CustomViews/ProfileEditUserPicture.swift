//
//  ProfileEditUserPicture.swift
//  NFT Marketplace
//
//  Created by Денис on 01.09.2023.
//

import UIKit

protocol ProfileEditUserPictureDelegate: AnyObject {
    func didTapTapOnImage()
}

final class ProfileEditUserPicture: UIView {
    
    weak var delegate: ProfileEditUserPictureDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(avatarImageTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    init(frame: CGRect, image: UIImage?, text: String) {
        super.init(frame: frame) 
        imageView.image = image
        label.text = text
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        addSubview(imageView)
        addSubview(dimmingView)
        addSubview(label)
        addSubview(overlayButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            dimmingView.topAnchor.constraint(equalTo: imageView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalToConstant: 30),
            
            overlayButton.topAnchor.constraint(equalTo: topAnchor),
            overlayButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    @objc func avatarImageTap() {
        print("Привет")
        delegate?.didTapTapOnImage()
    }
    
    func updateImage(_ image: UIImage) {
        imageView.image = image
    }
    
}
