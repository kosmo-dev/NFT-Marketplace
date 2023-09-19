//
//  ProfileModel.swift
//  NFT Marketplace
//
//  Created by Dzhami on 13.09.2023.
//

import Foundation

struct ProfileModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    var likes: [String]
    let id: String
}
