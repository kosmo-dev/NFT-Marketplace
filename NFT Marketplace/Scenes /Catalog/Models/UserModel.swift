//
//  UserModel.swift
//  NFT Marketplace
//
//  Created by Dzhami on 10.09.2023.
//

import Foundation

struct UserModel {
    let name: String
    let website: String
    let id: String
    
    init(with user: UserNetworkModel) {
        self.name = user.name
        self.website = user.website
        self.id = user.id
    }
}
