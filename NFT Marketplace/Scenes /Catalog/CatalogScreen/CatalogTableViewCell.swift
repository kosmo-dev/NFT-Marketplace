//
//  CatalogTableViewCell.swift
//  NFT Marketplace
//
//  Created by Dzhami on 28.08.2023.
//

import UIKit

final class CatalogTableViewCell: UITableViewCell, ReuseIdentifying {
        
     lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
     lazy var catalogNameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .blackDayNight
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell() {
        
        contentView.addSubview(cellImage)
        contentView.addSubview(catalogNameLabel)
        
        NSLayoutConstraint.activate([
            
            cellImage.heightAnchor.constraint(equalToConstant: 140),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            catalogNameLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 4),
            catalogNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}
