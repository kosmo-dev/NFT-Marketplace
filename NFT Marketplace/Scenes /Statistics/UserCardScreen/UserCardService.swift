//
//  UserCardModel.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit
import WebKit

final class UserCardService {
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
        return "\(nftCount ?? 0)"
    }
}
