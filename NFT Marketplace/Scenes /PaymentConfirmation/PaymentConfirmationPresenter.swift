//
//  PaymentConfirmationPresenter.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import Foundation

protocol PaymentConfirmationPresenterProtocol {
    var viewController: PaymentConfirmationViewControllerProtocol? { get set }

    func viewDidLoad()
    func buttonTapped()
}

final class PaymentConfirmationPresenter: PaymentConfirmationPresenterProtocol {
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

    func buttonTapped() {
        switch configuration {
        case .success:
            print("success")
        case .failure:
            viewController?.dismissViewController()
        }
    }
}

extension PaymentConfirmationPresenter {
    enum Configuration {
        case success
        case failure
    }
}
