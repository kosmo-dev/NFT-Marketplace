//
//  UserCardModel.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import Foundation

final class UserCardModel {
    var user: UserElement?
    
    init(user: UserElement) {
        self.user = user
    }
    
    func userName() -> String {
        return user?.name ?? ""
    }
    
    func userDescription() -> String {
        return user?.description ?? ""
    }
    
    func userNFT() -> String {
        let nftCount = user?.nfts.count
        print("user nft \(user?.nfts)")
        
        // тут всегда выходит ноль, массив nft почему-то пустой
        return "\(nftCount ?? 0)"
    }
}
