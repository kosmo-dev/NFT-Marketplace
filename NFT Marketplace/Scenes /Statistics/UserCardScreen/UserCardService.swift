//
//  UserCardModel.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit

final class UserCardService {
    var user: UserElement?
    let userAvatar: UIImageView?

    init(user: UserElement, userAvatar: UIImageView) {
        self.user = user
        self.userAvatar = userAvatar
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

    func userImage() -> UIImageView {
        return userAvatar ?? UIImageView()
    }
}
