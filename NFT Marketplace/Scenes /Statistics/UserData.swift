//
//  UserData.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit
import Kingfisher

protocol UserDataProtocol {
    var users: [UserElement] { get }
    
    func fetchUsers(completion: @escaping () -> Void)
    func downloadProfileImage(at index: Int, completion: @escaping (UIImage?) -> Void)
}

struct NFTRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/users")
}

final class UserData: UserDataProtocol {
    
    var users: [UserElement] = []
    let request = NFTRequest()
    let networkClient = DefaultNetworkClient()
    
    func fetchUsers(completion: @escaping () -> Void) {
        networkClient.send(request: request, type: [UserElement].self) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let userElement):
                    self.users = userElement
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func downloadProfileImage(at index: Int, completion: @escaping (UIImage?) -> Void) {
        guard index >= 0 && index < users.count else {
            completion(nil)
            return
        }
        
        let user = users[index]
        if let avatarURL = URL(string: user.avatar) {
            let imageView = UIImageView()
            imageView.kf.setImage(with: avatarURL) { result in
                switch result {
                case .success(let imageResult):
                    completion(imageResult.image)
                case .failure(_):
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}
