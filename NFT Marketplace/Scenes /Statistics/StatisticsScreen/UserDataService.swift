//
//  UserDataService.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit
import Kingfisher

protocol UserDataProtocol {
    var users: [UserElement] { get set }
    var sortDirection: SortDirection? { get set }
    
    func fetchUsers(completion: @escaping () -> Void)
    func loadProfileImage(imageView: UIImageView, url: String)
//    func downloadProfileImage(at index: Int, completion: @escaping (UIImage?) -> Void)
}

struct NFTRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/users")
}

final class UserDataService: UserDataProtocol {
    
    var users: [UserElement] = []
    var usersImages: [String: UIImage] = [:]
    var page = 20
    private let request = NFTRequest()
    private let networkClient = DefaultNetworkClient()
    var sortDirection: SortDirection? {
        get {
            guard let direction = UserDefaults.standard.string(forKey: "sortDirection") else { return SortDirection.empty }
            return SortDirection(rawValue: direction)
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue.rawValue, forKey: "sortDirection")
            }
        }
    }
    
    func fetchUsers(completion: @escaping () -> Void) {
        networkClient.send(request: request, type: [UserElement].self) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let userElements):
                    self.users = userElements
                    
                    if let sortDirection = self.sortDirection {
                        switch sortDirection {
                        case .sortByName:
                            self.users.sort { $0.name < $1.name }
                        case .sortByRating:
                            self.users.sort { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
                        case .empty:
                            print("No sorting chosen")
                        }
                    }
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func loadProfileImage(imageView: UIImageView, url: String) {
        guard let avatarURL = URL(string: url) else { return }
        imageView.kf.setImage(with: avatarURL) { result in
            switch result {
            case .success(let imageResult):
                print("Image loaded for \(url)")
            case .failure(let error):
                print(error)
            }
        }
     }
//    func downloadProfileImage(at index: Int, completion: @escaping (UIImage?) -> Void) {
//        var counter = 0
//        for index in 0...page {
//            let user = users[index]
//            guard let avatarURL = URL(string: user.avatar) else { return }
//
//            let imageView = UIImageView()
//            imageView.kf.setImage(with: avatarURL) { [weak self] result in
//                guard let self else { return }
//                switch result {
//                case .success(let imageResult):
//                    self.usersImages[user.avatar] = imageResult.image
//                    DispatchQueue.global().async {
//                        counter += 1
//                        if counter == self.page {
//                            completion(true)
//                        }
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }
    
    
    
    
    
    
    
    //    func downloadProfileImage(at index: Int, completion: @escaping (UIImage?) -> Void) {
    //        guard index >= 0 && index < users.count else {
    //            completion(nil)
    //            return
    //        }
    //
    //        let user = users[index]
    //        if let avatarURL = URL(string: user.avatar) {
    //            let imageView = UIImageView()
    //            imageView.kf.setImage(with: avatarURL) { result in
    //                switch result {
    //                case .success(let imageResult):
    //                    completion(imageResult.image)
    //                case .failure(_):
    //                    completion(nil)
    //                }
    //            }
    //        } else {
    //            completion(nil)
    //        }
    //    }
}

enum SortDirection: String {
    case empty
    case sortByName
    case sortByRating
}
