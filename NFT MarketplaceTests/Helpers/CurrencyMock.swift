//
//  CurrencyMock.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import Foundation
@testable import NFT_Marketplace

struct CurrencyMock {
    static let currencies: [Currency] = [
        Currency(title: "aa", image: "", id: "1", ticker: "A"),
        Currency(title: "bb", image: "", id: "2", ticker: "B"),
        Currency(title: "cc", image: "", id: "3", ticker: "C")
    ]
}
