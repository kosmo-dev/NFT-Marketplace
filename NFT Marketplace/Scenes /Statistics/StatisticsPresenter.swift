//
//  StatisticsPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit

protocol UserDataDelegate: AnyObject {
    var viewController: ViewControllerProtocol? { get set }
    
    func loadDataFromServer()
    func didLoadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void)
    func usersCount() -> Int
    func user(at index: Int) -> UserElement?
    func sortByName()
    func sortByRating()
    func sortButtonTapped() -> UIAlertController
}


final class StatisticsPresenter: UserDataDelegate {
    weak var viewController: ViewControllerProtocol?
    private var userDataModel: UserDataProtocol?
    
    init(userDataModel: UserDataProtocol) {
        self.userDataModel = userDataModel
    }
    
    func loadDataFromServer() {
        userDataModel?.fetchUsers() { [weak self] in
            guard let self = self else { return }
            self.viewController?.reloadTableView()
        }
    }
    
    func user(at index: Int) -> UserElement? {
        return userDataModel?.users[index]
    }
    
    func didLoadImageForUser(at index: Int, completion: @escaping (UIImage?) -> Void) {
        userDataModel?.downloadProfileImage(at: index) { image in
            guard let image = image else { return }
            completion(image)
        }
    }
    
    func usersCount() -> Int {
        return userDataModel?.users.count ?? 0
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
        userDataModel?.users.sort { $0.name < $1.name }
        userDataModel?.sortDirection = .sortByName
    }
    
    func sortByRating() {
        userDataModel?.users.sort { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
        userDataModel?.sortDirection = .sortByRating
    }
}
