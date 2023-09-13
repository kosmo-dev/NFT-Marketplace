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

struct ProfileRequest: NetworkRequest {
    var endpoint = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/profile/1")
}

struct UpdateProfileRequest: NetworkRequest {
    var endpoint = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/profile/1")
    var httpMethod: HttpMethod = HttpMethod.put
    var dto: Encodable?
}

final class UsersCollectionService: UsersCollectionProtocol {
    var NFTs: [NFT] = []
    var userProile: Profile?
    let user: UserElement
    
    private var NFTsImages: [String: UIImage] = [:]
    private let request = UsersRequest()
    private let networkClient = DefaultNetworkClient()
    
    init(user: UserElement) {
        self.user = user
    }
    
    func currentCount() -> Int {
        return NFTs.count
    }
    
    func fetchNFTs(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            UIBlockingProgressHUD.show()
        }
        
        var count = user.nfts.count
        networkClient.send(request: ProfileRequest(), type: Profile.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("Error fetching profile: \(error)")
            case .success(let profile):
                print("Got user profile: \(profile)")
                self.userProile = profile
                for id in self.user.nfts {
                    self.networkClient.send(request: NFTRequest(id: id), type: NFT.self) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let nft):
                                self.NFTs.append(nft)
                            case .failure(let error):
                                print("Error fetching NFTs: \(error)")
                            }
                            count -= 1
                            if count == 0 {
                                DispatchQueue.main.async {
                                    UIBlockingProgressHUD.dismiss()
                                    completion()
                                }
                            }
                        }
                    }
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
    
    func putProfile(profile: Profile, completion: @escaping () -> Void) {
        self.networkClient.send(request: UpdateProfileRequest(dto: profile)) {result in
            switch result {
            case .success(let response):
                print(String(decoding: response, as: UTF8.self))
                self.userProile = profile
                completion()
            case .failure(let error):
                print("Error udpating user: \(error)")
            }
        }
    }
}
