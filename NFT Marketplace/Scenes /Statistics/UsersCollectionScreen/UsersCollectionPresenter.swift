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
    func liked(id: String) -> Bool?
    func tapLike(_ cell: NFTCollectionCell)
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

    func liked(id: String) -> Bool? {
        return self.usersCollectionService.userProile?.likes.contains(id)
    }

    func tapLike(_ cell: NFTCollectionCell) {
        // get profile
        var userProfile = usersCollectionService.userProile
        guard let userProfile = userProfile, let nftId = cell.nftId else { return }
        // check that [likes] contians cell.nftId
        // if not - add, if contains - remove from [likes]
        var newLikes = userProfile.likes
        if !userProfile.likes.contains(nftId) {
            newLikes.append(nftId)
        } else {
            newLikes = newLikes.filter {
                $0 != nftId
            }
        }
        let newProfile = Profile(
            name: userProfile.name,
            description: userProfile.description,
            website: userProfile.website,
            likes: newLikes
        )
        print("New like array: \(newProfile)")
        // put profile
        usersCollectionService.putProfile(
            profile: newProfile
        ) {
            self.view?.reloadCollectionView()
        }
    }
}
