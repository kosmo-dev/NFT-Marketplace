//
//  Users.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 29.08.2023.
//


// To parse the JSON, add this file to your project and do:
//
//   let user = try? JSONDecoder().decode(User.self, from: jsonData)

import Foundation

struct Users: Codable {
    let errorMessage: String
    let items: [UserElement]
}

struct UserElement: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating, id: String
}
