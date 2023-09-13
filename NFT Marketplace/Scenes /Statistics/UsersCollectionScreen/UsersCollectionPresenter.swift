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
    func addedToCart(nft: NFT) -> Bool?
    func tapLike(_ cell: NFTCollectionCell)
    func cartButtonTapped(cell: NFTCollectionCell)
    func updateCell(at index: Int)
}

final class UsersCollectionPresenter: UsersCollectionPresenterProtocol {
    weak var view: UsersCollectionViewControllerProtocol?
    
    private let cartController: CartControllerProtocol
    private let usersCollectionService: UsersCollectionService

    init(model: UsersCollectionService, cartController: CartControllerProtocol) {
        self.usersCollectionService = model
        self.cartController = cartController
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

    func cartButtonTapped(cell: NFTCollectionCell) {
        let indexPath = IndexPath(row: cell.likeButton.tag, section: 0)

        guard let nft = cell.nftModel else { return }
        if cartController.cart.contains(where: { $0.id == nft.id }) {
            cartController.removeFromCart(nft) {
                print("Removed from cart")
            }
        } else {
            cartController.addToCart(nft) {
                print("Added to cart")
            }
        }
        self.view?.updateCell(at: indexPath.row)
    }

    func addedToCart(nft: NFT) -> Bool? {
        return self.cartController.cart.contains( where: { $0.id == nft.id })
    }

    func liked(id: String) -> Bool? {
        return self.usersCollectionService.userProile?.likes.contains(id)
    }

    func tapLike(_ cell: NFTCollectionCell) {
        let indexPath = IndexPath(row: cell.likeButton.tag, section: 0)

        let userProfile = usersCollectionService.userProile
        guard let userProfile = userProfile, let nft = cell.nftModel else { return }

        var newLikes = userProfile.likes
        if !userProfile.likes.contains(nft.id) {
            newLikes.append(nft.id)
        } else {
            newLikes = newLikes.filter {
                $0 != nft.id
            }
        }
        let newProfile = Profile(
            name: userProfile.name,
            description: userProfile.description,
            website: userProfile.website,
            likes: newLikes
        )
        usersCollectionService.putProfile(
            profile: newProfile
        ) {
            self.view?.updateCell(at: indexPath.row)
        }
    }

    func updateCell(at index: Int) {
        view?.updateCell(at: index)
    }
}
