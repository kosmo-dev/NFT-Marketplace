//
//  Currency.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 01.09.2023.
//

import Foundation

struct Currency {
    let title: String
    let image: String
    let id: String
    let ticker: String
}

extension Currency: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case id
        case ticker = "name"
    }
}
