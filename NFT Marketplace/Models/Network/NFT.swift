//
//  NFT.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import Foundation

struct NFT: Codable {
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let id: String
    let createdAt: String
}

extension NFT: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: NFT, rhs: NFT) -> Bool {
        lhs.id == rhs.id
    }
}
