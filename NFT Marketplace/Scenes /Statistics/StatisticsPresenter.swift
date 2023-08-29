//
//  StatisticsPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit

protocol UserDataDelegate: AnyObject {
    var viewController: ViewControllerProtocol? { get set }
    
    func didLoadDataFromServer()
    func didLoadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void)
    func usersCount() -> Int
    func user(at index: Int) -> UserElement?
}


final class StatisticsPresenter: UserDataDelegate {
    weak var viewController: ViewControllerProtocol?
    var userData: UserDataProtocol?
    
    init(userData: UserDataProtocol) {
        self.userData = userData
    }
    
    func didLoadDataFromServer() {
        userData?.fetchUsers() {
            self.viewController?.reloadTableView()
        }
    }
    
    func user(at index: Int) -> UserElement? {
        return userData?.users[index]
        }
    
    func didLoadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void) {
        userData?.downloadImageForUser(at: index) { image in
            guard let image = image else { return }
            completion(image)
        }
    }
    
    func usersCount() -> Int {
        return userData?.users.count ?? 0
    }
}
