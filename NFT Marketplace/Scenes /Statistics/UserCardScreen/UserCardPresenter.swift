//
//  UserCardPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit
import WebKit

protocol UserCardDelegate: AnyObject {
    func getUserName() -> String
    func getUserDescription() -> String
    func getNFT() -> String
}

final class UserCardPresenter: UserCardDelegate {

    private let userCardService: UserCardService

    init(model: UserCardService) {
        self.userCardService = model
    }

    func getUserName() -> String {
        return self.userCardService.userName()
    }

    func getUserDescription() -> String {
        return self.userCardService.userDescription()
    }

    func getNFT() -> String {
        return self.userCardService.userNFT()
    }

    func getUserImage() -> UIImageView {
        return self.userCardService.userImage()
    }

    func webSiteView() -> UIViewController? {
        guard let user = userCardService.user,
              let url = URL(string: user.website)
        else { return nil }
        let userWebsiteController = UserWebsiteWebView(request: URLRequest(url: url))
        userWebsiteController.modalPresentationStyle = .pageSheet
        return userWebsiteController
    }

    func userNFTIds() -> [String] {
        let nftIds = userCardService.user?.nfts
        return nftIds ?? []
    }
}
