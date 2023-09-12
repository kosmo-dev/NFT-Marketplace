//
//  UsersCollectionService.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 09.09.2023.
//

import UIKit
import Kingfisher

protocol UsersCollectionProtocol {
    var NFTs: [NFT] { get set }

    func currentCount() -> Int
    func fetchNFTs(completion: @escaping () -> Void)
    func loadNFTImage(imageView: UIImageView, url: String)
}

struct NFTRequest: NetworkRequest {
    var id: String
    var endpoint: URL? {
        URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/nft/\(self.id)")
    }
}

final class UsersCollectionService: UsersCollectionProtocol {

    let userNFTIds: [String]

    var NFTs: [NFT] = []
    var NFTsImages: [String: UIImage] = [:]

    private let request = UsersRequest()
    private let networkClient = DefaultNetworkClient()

    init(userNFTIds: [String]) {
        self.userNFTIds = userNFTIds
    }

    func currentCount() -> Int {
        return NFTs.count
    }

    func fetchNFTs(completion: @escaping () -> Void) {
        UIBlockingProgressHUD.show()
        var count = userNFTIds.count
        for id in userNFTIds {
            networkClient.send(request: NFTRequest(id: id), type: NFT.self) { result in
                switch result {
                case .success(let nft):
                    self.NFTs.append(nft)
                    print("NFT Name: \(nft.name)")
                    print("NFT Images: \(nft.images)")
                case .failure(let error):
                    print("Error fetching NFTs: \(error)")
                }
                count -= 1
                if count == 0 {
                    UIBlockingProgressHUD.dismiss()
                    completion()
                }
            }
        }
    }

    func loadNFTImage(imageView: UIImageView, url: String) {
        guard let NFTImageURL = URL(string: url) else { return }
        imageView.kf.setImage(with: NFTImageURL) { result in
            switch result {
            case .success:
                print("Image loaded for \(url)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
