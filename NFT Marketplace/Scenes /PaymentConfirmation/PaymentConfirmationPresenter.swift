//
//  PaymentConfirmationPresenter.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import Foundation

protocol PaymentConfirmationPresenterProtocol {
    var viewController: PaymentConfirmationViewControllerProtocol { get set }

    func viewDidLoad()
}

final class PaymentConfirmationPresenter {
    weak var viewController: PaymentConfirmationViewControllerProtocol?
    private var configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    func viewDidLoad() {
        switch configuration {
        case .success:
            viewController?.configureElements(
                imageName: "PaymentSuccededImage",
                description: TextStrings.PaymentConfirmationViewController.paymentConfirmed,
                buttonText: TextStrings.PaymentConfirmationViewController.returnButton)
        case .failure:
            viewController?.configureElements(
                imageName: "PaymentFailedImage",
                description: TextStrings.PaymentConfirmationViewController.paymentFailed,
                buttonText: TextStrings.PaymentConfirmationViewController.tryAgainButton)
        }
    }
}

extension PaymentConfirmationPresenter {
    enum Configuration {
        case success
        case failure
    }
}
