//
//  File.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import Foundation

struct OrderResponse: Decodable {
    let nfts: [String]
    let id: String
}
