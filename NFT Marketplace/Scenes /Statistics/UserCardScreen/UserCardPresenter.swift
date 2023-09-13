//
//  UserCardPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit
import SafariServices

protocol UserCardDelegate: AnyObject {
    var view: UserCardViewControllerProtocol? { get set }

    func user() -> UserElement?
    func getUserInfo()
}

final class UserCardPresenter: UserCardDelegate {
    weak var view: UserCardViewControllerProtocol?
    private let userCardService: UserCardService

    init(model: UserCardService) {
        self.userCardService = model
    }

    func getUserInfo() {
        view?.userName.text = self.userCardService.userName()
        view?.userDescription.text = self.userCardService.userDescription()
        view?.userCollectionsButton.setTitle(
            TextLabels.UserCardVC.userCollectionsButtonTitle+" (\(self.userCardService.userNFT()))",
            for: .normal
        )
        view?.userAvatar.image = self.userCardService.userImage().image ?? UIImage()
    }

    func webSiteView() -> SFSafariViewController? {
        guard let user = userCardService.user,
              let url = URL(string: user.website)
        else { return nil }

        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }

    func user() -> UserElement? {
        return userCardService.user
    }
}
