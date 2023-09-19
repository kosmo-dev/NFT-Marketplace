//
//  Profile.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 13.09.2023.
//

import Foundation

struct Profile: Codable {
    let name: String
    let description: String
    let website: String
    let likes: [String]
}
