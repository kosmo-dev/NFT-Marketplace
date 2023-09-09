//
//  NFTModel.swift
//  NFT Marketplace
//
//  Created by Денис on 07.09.2023.
//

import Foundation

struct NFTModel: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
