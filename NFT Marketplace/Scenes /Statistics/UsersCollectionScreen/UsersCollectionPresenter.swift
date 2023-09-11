//
//  UsersCollectionPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 09.09.2023.
//

import Foundation

protocol UsersCollectionPresenterProtocol: AnyObject {
    var view: UsersCollectionViewControllerProtocol? { get set }

    func userNFTcount() -> Int
}

final class UsersCollectionPresenter: UsersCollectionPresenterProtocol {
    weak var view: UsersCollectionViewControllerProtocol?

    private let usersCollectionService: UsersCollectionService

    init(model: UsersCollectionService) {
        self.usersCollectionService = model
    }

    func userNFTcount() -> Int {
        let nftCount = usersCollectionService.userNFTIds.count
        return nftCount
    }

}
