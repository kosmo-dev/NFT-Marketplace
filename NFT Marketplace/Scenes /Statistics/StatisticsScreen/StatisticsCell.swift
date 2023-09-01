//
//  StatisticsCell.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 27.08.2023.
//

import UIKit

final class StatisticsCell: UITableViewCell, ReuseIdentifying {
    
    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.font = UIFont.caption1
        numberLabel.textAlignment = .center
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()
    
    private let backgroundCardView: UIView = {
        let backgroundCardView = UIView()
        backgroundCardView.backgroundColor = .lightGreyDayNight
        backgroundCardView.layer.cornerRadius = 12
        backgroundCardView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundCardView
    }()
    
    var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        //        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        avatarImage.clipsToBounds = true
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
    private let nameTitleLabel: UILabel = {
        let nameTitleLabel = UILabel()
        nameTitleLabel.font = UIFont.headline3
        nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameTitleLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = UIFont.headline3
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        clipsToBounds = true
        
        addSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberLabel.heightAnchor.constraint(equalToConstant: 20),
            numberLabel.widthAnchor.constraint(equalToConstant: 27),
            
            backgroundCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            backgroundCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundCardView.heightAnchor.constraint(equalToConstant: 80),
            
            avatarImage.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 16),
            avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 28),
            avatarImage.widthAnchor.constraint(equalToConstant: 28),
            
            nameTitleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8),
            nameTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            ratingLabel.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -16),
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func addSubviews() {
        addSubview(numberLabel)
        addSubview(backgroundCardView)
        addSubview(avatarImage)
        addSubview(nameTitleLabel)
        addSubview(ratingLabel)
    }
    
    func updateCell(number: Int, avatar: UIImage, name: String, rating: String) {
        numberLabel.text = "\(number)"
        avatarImage.image = avatar
        nameTitleLabel.text = name
        ratingLabel.text = rating
    }
}
