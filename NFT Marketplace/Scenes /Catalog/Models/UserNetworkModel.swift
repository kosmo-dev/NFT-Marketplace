//
//  UserNetworkModel.swift
//  NFT Marketplace
//
//  Created by Dzhami on 09.09.2023.
//

import Foundation

struct UserNetworkModel: Decodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}
