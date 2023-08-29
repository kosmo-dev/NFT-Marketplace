//
//  UserProfile.swift
//  NFT Marketplace
//
//  Created by Денис on 29.08.2023.
//

import Foundation

struct UserProfile: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
