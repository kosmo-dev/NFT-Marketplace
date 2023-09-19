//
//  ProfileUpdateRequest.swift
//  NFT Marketplace
//
//  Created by Dzhami on 13.09.2023.
//

import Foundation

struct ProfileUpdateRequest: NetworkRequest {
    var endpoint = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/profile/1")
    var httpMethod: HttpMethod = .put
    var dto: Encodable?
}



