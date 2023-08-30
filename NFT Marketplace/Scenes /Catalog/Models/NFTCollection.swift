//
//  NFTCollection.swift
//  NFT Marketplace
//
//  Created by Dzhami on 29.08.2023.
//

import Foundation

struct NFTCollection: Decodable {
    let createdAt: Date
    let name: String
    let cover: String
    let nfts: [Int]
    let description: String
    let author: Int
    let id: String
}
