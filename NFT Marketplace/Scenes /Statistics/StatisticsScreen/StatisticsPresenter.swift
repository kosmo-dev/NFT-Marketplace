//
//  StatisticsPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 28.08.2023.
//

import UIKit
import Kingfisher

protocol StatisticsPresenterProtocol: AnyObject {
    var view: StatisticsViewControllerProtocol? { get set }

    func loadDataFromServer()
    func loadProfileImage(imageView: UIImageView, url: String)
    func usersCount() -> Int
    func user(at index: Int) -> UserElement?
    func sortByName()
    func sortByRating()
    func sortButtonTapped() -> UIAlertController
}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    weak var view: StatisticsViewControllerProtocol?
    private var userDataService: UserDataProtocol

    init(userDataService: UserDataProtocol) {
        self.userDataService = userDataService
    }

    func loadDataFromServer() {
        userDataService.fetchUsers { [weak self] in
            guard let self = self else { return }
            self.view?.reloadTableView()
        }
    }

    func user(at index: Int) -> UserElement? {
        return userDataService.users[index]
    }

    func loadProfileImage(imageView: UIImageView, url: String) {
        userDataService.loadProfileImage(imageView: imageView, url: url)
    }

    func usersCount() -> Int {
        return userDataService.users.count
    }

    func sortButtonTapped() -> UIAlertController {
        let alertController = UIAlertController(
            title: TextLabels.StatisticsVC.sortingTitle,
            message: nil,
            preferredStyle: .actionSheet
        )

        let sortByNameAction = UIAlertAction(title: TextLabels.StatisticsVC.sortByNameTitle, style: .default) { _ in
            self.sortByName()
            self.view?.reloadTableView()
        }
        alertController.addAction(sortByNameAction)

        let sortByRatingAction = UIAlertAction(title: TextLabels.StatisticsVC.sortByRatingTitle, style: .default) { _ in
            self.sortByRating()
            self.view?.reloadTableView()
        }
        alertController.addAction(sortByRatingAction)

        let closeAction = UIAlertAction(title: TextLabels.StatisticsVC.closeTitle, style: .cancel, handler: nil)
        alertController.addAction(closeAction)

        return alertController
    }

    func sortByName() {
        userDataService.users.sort { $0.name < $1.name }
        userDataService.sortDirection = .sortByName
    }

    func sortByRating() {
        userDataService.users.sort { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
        userDataService.sortDirection = .sortByRating
    }
}
