//
//  UserCardPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import Foundation

protocol UserCardDelegate: AnyObject {
    func getUserName() -> String
    func getUserDescription() -> String
    func getNFT() -> String
}

final class UserCardPresenter: UserCardDelegate {
    
    var model: UserCardModel?
    
    init(model: UserCardModel) {
        self.model = model
    }
    
    func getUserName() -> String {
        return self.model?.userName() ?? ""
    }
    
    func getUserDescription() -> String {
        return self.model?.userDescription() ?? ""
    }
    
    func getNFT() -> String {
        return self.model?.userNFT() ?? ""
    }
}
