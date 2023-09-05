//
//  PaymentRequests.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import Foundation

struct CurrenciesRequest: NetworkRequest {
    let requestId = "CurrenciesRequest"
    var endpoint: URL? = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/currencies")
}
