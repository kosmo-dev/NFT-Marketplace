//
//  PaymentPresenterTests.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import XCTest
@testable import NFT_Marketplace

final class PaymentPresenterTests: XCTestCase {

    func testViewDidLoadChangesStateToLoading() {
        // Given
        let networkManager = NetworkManagerStub()
        let paymentManager = PaymentManagerStub()
        let cartController = CartControllerStub()
        let presenter = PaymentPresenter(
            networkManager: networkManager, paymentManager: paymentManager, cartController: cartController)
        let viewController = PaymentViewControllerSpy()
        presenter.viewController = viewController

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(viewController.isLoading)
    }

    func testSuccessfulFetchDataChangesStateToLoaded() {
        // Given
        let networkManager = NetworkManagerStub()
        let paymentManager = PaymentManagerStub()
        let cartController = CartControllerStub()
        let presenter = PaymentPresenter(
            networkManager: networkManager, paymentManager: paymentManager, cartController: cartController)
        let viewController = PaymentViewControllerSpy()
        presenter.viewController = viewController
        let expectation = self.expectation(description: "wait for async operation")
        viewController.expectation = expectation

        // When
        presenter.viewDidLoad()

        // Wait
        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail()
            }
            XCTAssertTrue(viewController.isLoaded)
        }
    }
}
