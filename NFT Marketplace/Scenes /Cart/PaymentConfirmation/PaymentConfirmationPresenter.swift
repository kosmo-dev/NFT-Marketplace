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

protocol PaymentConfirmationPresenterDelegate: AnyObject {
    func didTapDismissButton()
}

final class PaymentConfirmationPresenter: PaymentConfirmationPresenterProtocol {
    weak var viewController: PaymentConfirmationViewControllerProtocol?
    weak var delegate: PaymentConfirmationPresenterDelegate?
    private var configuration: Configuration
    private let storeRatingService = StoreRatingService()


    init(configuration: Configuration) {
        self.configuration = configuration
    }

    func viewDidLoad() {
        switch configuration {
        case .success:
            viewController?.configureElements(
                imageName: "PaymentSuccededImage",
                description: TextLabels.PaymentConfirmationViewController.paymentConfirmed,
                buttonText: TextLabels.PaymentConfirmationViewController.returnButton)
        case .failure:
            viewController?.configureElements(
                imageName: "PaymentFailedImage",
                description: TextLabels.PaymentConfirmationViewController.paymentFailed,
                buttonText: TextLabels.PaymentConfirmationViewController.tryAgainButton)
        }
        guard configuration == .success,
              storeRatingService.checkNeedShowRating()
        else { return }
        self.viewController?.presentRatingView()

    }

    func buttonTapped() {
        delegate?.didTapDismissButton()
    }
}

extension PaymentConfirmationPresenter {
    enum Configuration {
        case success
        case failure
    }
}
