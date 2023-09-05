//
//  PaymentViewControllerSpy.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import UIKit
import XCTest
@testable import NFT_Marketplace

final class PaymentViewControllerSpy: PaymentViewControllerProtocol {
    var isLoading = false
    var isLoaded = false
    var expectation: XCTestExpectation?

    func reloadCollectionView() {}

    func displayLoadingIndicator() {
        isLoading = true
    }

    func removeLoadingIndicator() {
        isLoaded = true
        expectation?.fulfill()
    }

    func presentView(_ viewController: UIViewController) {}

    func changeButtonState(color: UIColor, isEnabled: Bool, isLoading: Bool) {}
}
