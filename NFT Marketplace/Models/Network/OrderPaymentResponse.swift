//
//  OrderPaymentResponse.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import Foundation

struct OrderPaymentResponse: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
