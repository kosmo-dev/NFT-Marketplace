//
//  NFTCollectionsRequest.swift
//  NFT Marketplace
//
//  Created by Dzhami on 29.08.2023.
//

import Foundation

struct NFTTableViewRequest: NetworkRequest {
    var endpoint: URL?

    init() {
        guard let endpoint = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/collections") else { return }
        self.endpoint = endpoint
    }
}
