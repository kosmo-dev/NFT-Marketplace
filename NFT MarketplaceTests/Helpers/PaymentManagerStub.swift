//
//  PaymentManagerStub.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import Foundation
@testable import NFT_Marketplace

final class PaymentManagerStub: PaymentManagerProtocol {
    var delegate: NFT_Marketplace.PaymentManagerDelegate?

    func performPayment(nfts: [String], currencyId: Int) {
        delegate?.paymentFinishedWithSuccess()
    }
}
