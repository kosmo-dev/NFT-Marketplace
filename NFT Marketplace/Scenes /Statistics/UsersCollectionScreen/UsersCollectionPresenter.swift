//
//  UsersCollectionPresenter.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 09.09.2023.
//

import UIKit

protocol UsersCollectionPresenterProtocol: AnyObject {
    var view: UsersCollectionViewControllerProtocol? { get set }
    
    func userNFTcount() -> Int
    func loadNFTFromServer()
    func nfts(at index: Int) -> NFT?
    func loadNFTImage(imageView: UIImageView, url: String)
}

final class UsersCollectionPresenter: UsersCollectionPresenterProtocol {
    weak var view: UsersCollectionViewControllerProtocol?
    
    private let usersCollectionService: UsersCollectionService
    
    init(model: UsersCollectionService) {
        self.usersCollectionService = model
    }
    
    func userNFTcount() -> Int {
        return usersCollectionService.currentCount()
    }
    
    func loadNFTFromServer() {
        usersCollectionService.fetchNFTs { [weak self] in
            guard let self = self else { return }
            self.view?.reloadCollectionView()
        }
    }
    
    func loadNFTImage(imageView: UIImageView, url: String) {
        usersCollectionService.loadNFTImage(imageView: imageView, url: url)
    }
    
    func nfts(at index: Int) -> NFT? {
        return usersCollectionService.NFTs[index]
    }
}
