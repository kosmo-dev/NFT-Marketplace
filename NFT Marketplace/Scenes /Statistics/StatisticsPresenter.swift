//
//  StatisticsPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit

protocol PresenterProtocol {
    var view: ViewControllerProtocol? { get set }
    var users: [UserElement] { get }
    func fetchUsers()
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    func downloadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void)
}

struct NFTRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://64e794e8b0fd9648b7902516.mockapi.io/api/v1/users")
}


final class StatisticsPresenter: PresenterProtocol {
    weak var view: ViewControllerProtocol?
    
    var users: [UserElement] = []
    let request = NFTRequest()
    let networkClient = DefaultNetworkClient()
    
    func fetchUsers() {
        networkClient.send(request: request, type: [UserElement].self) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let userElement):
                    self.users = userElement
                    
                case .failure(let error):
                    print(error)
                }
            }
            self?.view?.reloadTableView()
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
            guard index >= 0 && index < users.count else {
                completion(nil)
                return
            }
            
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
