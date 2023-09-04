//
//  UserCardPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 31.08.2023.
//

import UIKit
import WebKit

protocol UserCardDelegate: AnyObject {
    var webView: WKWebView? { get }
    
    func getUserName() -> String
    func getUserDescription() -> String
    func getNFT() -> String
}

final class UserCardPresenter: UserCardDelegate {
    
    var userCardService: UserCardService?
    var webView: WKWebView?
    
    init(model: UserCardService) {
        self.userCardService = model
    }
    
    func getUserName() -> String {
        return self.userCardService?.userName() ?? ""
    }
    
    func getUserDescription() -> String {
        return self.userCardService?.userDescription() ?? ""
    }
    
    func getNFT() -> String {
        return self.userCardService?.userNFT() ?? ""
    }
    
    func getUserImage() -> UIImageView {
        return self.userCardService?.userImage() ?? UIImageView()
    }
    
    func webSiteView() -> UIViewController? {
        guard let user = userCardService?.user,
              let url = URL(string: user.website)
        else { return nil }
        let userWebsiteController = UserWebsiteWebView(request: URLRequest(url: url))
        userWebsiteController.modalPresentationStyle = .pageSheet
        return userWebsiteController
    }
}
