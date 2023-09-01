//
//  StatisticsPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit
import Kingfisher

protocol UserDataDelegate: AnyObject {
    var viewController: ViewControllerProtocol? { get set }
    
    func loadDataFromServer()
//    func didLoadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void)
    func loadProfileImage(imageView: UIImageView, url: String)
    func usersCount() -> Int
    func user(at index: Int) -> UserElement?
    func sortByName()
    func sortByRating()
    func sortButtonTapped() -> UIAlertController
}


final class StatisticsPresenter: UserDataDelegate {
    weak var viewController: ViewControllerProtocol?
    private var userDataService: UserDataProtocol?
    
    init(userDataService: UserDataProtocol) {
        self.userDataService = userDataService
    }
    
    func loadDataFromServer() {
        userDataService?.fetchUsers() { [weak self] in
            guard let self = self else { return }
            self.viewController?.reloadTableView()

//            self.userDataService?.downloadProfileImage(at: index, completion: { completed in
//                if completed {
//                    self.viewController?.reloadTableView()
//                }
//            })
        }
    }
    
    func user(at index: Int) -> UserElement? {
        return userDataService?.users[index]
    }
    
    func loadProfileImage(imageView: UIImageView, url: String) {
        userDataService?.loadProfileImage(imageView: imageView, url: url)
     }
    
//    func didLoadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void) {
//        userDataService?.downloadProfileImage(at: index) { image in
//            guard let image = image else { return }
//            completion(image)
//        }
//    } 
    
    func usersCount() -> Int {
        return userDataService?.users.count ?? 0
    }
    
    func sortButtonTapped() -> UIAlertController {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        
        let sortByNameAction = UIAlertAction(title: "По имени", style: .default) { _ in
            self.sortByName()
            self.viewController?.reloadTableView()
        }
        alertController.addAction(sortByNameAction)
        
        let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { _ in
            self.sortByRating()
            self.viewController?.reloadTableView()
        }
        alertController.addAction(sortByRatingAction)
        
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        
        return alertController
    }
    
    func sortByName() {
        userDataService?.users.sort { $0.name < $1.name }
        userDataService?.sortDirection = .sortByName
    }
    
    func sortByRating() {
        userDataService?.users.sort { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
        userDataService?.sortDirection = .sortByRating
    }
}
