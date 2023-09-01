//
//  NFTCollection.swift
//  NFT Marketplace
//
//  Created by Dzhami on 29.08.2023.
//

import Foundation

struct NFTCollection: Decodable {
    let name: String
    let cover: String
    let nfts: [String]
    let id: String
    
    var nftCount: Int {
        nfts.count
    }
}
