//
//  ProfileButton.swift
//  NFT Marketplace
//
//  Created by Денис on 26.08.2023.
//

import UIKit

final class ProfileButton: UIButton {
    
    //MARK: -Privite Properties
    private let arrowImage = UIImage(systemName: "chevron.forward")
    
    //MARK: -Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Private Methods
    private func setupButton(){
        //верстаю стрелку
        setImage(arrowImage, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = .blackDayNight
        
        //верстаю текст
        setTitleColor(.blackDayNight, for: .normal)
        titleLabel?.numberOfLines = 1
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        //настройка расположения элементов
        contentHorizontalAlignment = .left
        
        contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
 
    }
    
    func setText(_ text: String) {
        setTitle(text, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageEdgeInsets = UIEdgeInsets(top: 0, left: bounds.width - 16 - (imageView?.bounds.width ?? 0), bottom: 0, right: 16)
    }
    
}
