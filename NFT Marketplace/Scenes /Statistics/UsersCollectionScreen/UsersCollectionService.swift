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

//    func fetchUsers(completion: @escaping () -> Void)
//    func loadProfileImage(imageView: UIImageView, url: String)
}

struct NFTRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/users")
}

final class UsersCollectionService: UsersCollectionProtocol {

    let userNFTIds: [String]

    var NFTs: [NFT] = []
    var NFTsImages: [String: UIImage] = [:]

    private let request = NFTRequest()
    private let networkClient = DefaultNetworkClient()

    init(userNFTIds: [String]) {
        self.userNFTIds = userNFTIds
    }

//    func fetchUsers(completion: @escaping () -> Void) {
//        UIBlockingProgressHUD.show()
//        networkClient.send(request: request, type: [UserElement].self) { [weak self] result in
//            DispatchQueue.main.async {
//                guard let self = self else { return }
//                switch result {
//                case .success(let userElements):
//                    self.users = userElements
//
//                    if let sortDirection = self.sortDirection {
//                        switch sortDirection {
//                        case .sortByName:
//                            self.users.sort { $0.name < $1.name }
//                        case .sortByRating:
//                            self.users.sort { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
//                        case .empty:
//                            print("No sorting chosen")
//                        }
//                    }
//                    completion()
//                case .failure(let error):
//                    print(error)
//                }
//                UIBlockingProgressHUD.dismiss()
//            }
//        }
//    }
//
//    func loadProfileImage(imageView: UIImageView, url: String) {
//        guard let avatarURL = URL(string: url) else { return }
//        imageView.kf.setImage(with: avatarURL) { result in
//            switch result {
//            case .success:
//                print("Image loaded for \(url)")
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
