//
//  UserData.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit

protocol UserDataProtocol {
    var users: [UserElement] { get }
    
    func fetchUsers(completion: @escaping () -> Void)
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    func downloadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void)
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
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func downloadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void) {
        
        let user = users[index]
        if let avatarURL = URL(string: user.avatar) {
            downloadImage(from: avatarURL) { image in
                completion(image)
            }
        } else {
            completion(nil)
        }
    }
}
