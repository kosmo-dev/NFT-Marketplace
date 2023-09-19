//
//  NFTGetRequest.swift
//  NFT Marketplace
//
//  Created by Dzhami on 10.09.2023.
//

import Foundation

struct NFTGetRequest: NetworkRequest {
    var endpoint: URL?

    init(id: String) {
           guard let endpoint = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/nft/\(id)") else { return }
           self.endpoint = endpoint
       }
}
