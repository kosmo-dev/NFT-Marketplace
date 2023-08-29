//
//  Users.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 29.08.2023.
//

import Foundation

struct UserElement: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating, id: String
}
