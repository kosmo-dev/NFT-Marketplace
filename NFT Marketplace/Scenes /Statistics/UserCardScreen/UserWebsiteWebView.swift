//
//  UserWebsiteWebView.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 01.09.2023.
//

import UIKit
import WebKit

final class UserWebsiteWebView: UIViewController, WKNavigationDelegate {
    
    private var request: URLRequest?
    let webView = WKWebView()

    init(request: URLRequest?) {
        super.init(nibName: nil, bundle: nil)
        self.request = request
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let request = request else { return }
        view = webView
        webView.navigationDelegate = self
        webView.load(request)
    }
}
