//
//  UserWebsiteWebView.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 01.09.2023.
//

import UIKit
import WebKit

final class UserWebsiteWebView: UIViewController {

    private var request: URLRequest?
    private let webView = WKWebView()

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

        view.backgroundColor = .whiteDayNight
        webView.load(request)

        view.addSubview(webView)
        setupConstraints()

        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .blackDayNight
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
