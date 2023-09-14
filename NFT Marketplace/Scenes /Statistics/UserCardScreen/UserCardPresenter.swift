//
//  UserCardPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit
import WebKit

protocol UserCardDelegate: AnyObject {
    var view: UserCardViewControllerProtocol? { get set }

    func user() -> UserElement?
    func viewDidLoad()
}

final class UserCardPresenter: UserCardDelegate {
    weak var view: UserCardViewControllerProtocol?
    private let userCardService: UserCardService

    init(model: UserCardService) {
        self.userCardService = model
    }

    func viewDidLoad() {
        view?.update(with: makeViewModel())
    }

    func user() -> UserElement? {
        return userCardService.user
    }

    func webSiteView() -> UIViewController? {
        guard let user = userCardService.user,
              let url = URL(string: user.website)
        else { return nil }

        let userWebsiteController = UserWebsiteWebView(request: URLRequest(url: url))
        let navigationController = UINavigationController(rootViewController: userWebsiteController)
        navigationController.navigationBar.tintColor = .blackDayNight

        return navigationController
    }

    private func makeViewModel() -> UserViewModel {
        let name = self.userCardService.userName()
        let description = self.userCardService.userDescription()
        let buttonText = TextLabels.UserCardVC.userCollectionsButtonTitle + " (\(self.userCardService.userNFT()))"
        let image = self.userCardService.userImage().image ?? UIImage()

        let userViewModel = UserViewModel(
            userName: name,
            userDescription: description,
            userCollectionsButtonText: buttonText,
            userAvatar: image)

        return userViewModel
    }
}
