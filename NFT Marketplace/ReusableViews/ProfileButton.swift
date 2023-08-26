//
//  ProfileButton.swift
//  NFT Marketplace
//
//  Created by Денис on 26.08.2023.
//

import UIKit

final class ProfileButton: UIButton {
    
    //MARK: -Privite Properties
    private let arrowImage = UIImage(systemName: "arrow.right")
    
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
        
        //верстаю текст
        setTitleColor(.blackDayNight, for: .normal)
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        //настройка расположения элементов
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: bounds.width - 16 - (imageView?.bounds.width ?? 0), bottom: 0, right: 16)
    }
    ///Задаем текст с учетом конкатенции данных о колличестве NFT (если не нужны Count-данные - просто их не пишем)
    func setText(from buttonLabel: String, and NFTCount: Int?) {
        var finalText: String
        if let count = NFTCount {
            finalText = "\(buttonLabel) \(count)"
        } else {
            finalText = buttonLabel
        }
        setTitle(finalText, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageEdgeInsets = UIEdgeInsets(top: 0, left: bounds.width - 16 - (imageView?.bounds.width ?? 0), bottom: 0, right: 16)
    }
    
}
