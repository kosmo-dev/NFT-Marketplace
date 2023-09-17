//
//  CatalogСollectionPresenter.swift
//  NFT Marketplace
//
//  Created by Dzhami on 07.09.2023.
//

import Foundation

// MARK: - Protocol

protocol CatalogСollectionPresenterProtocol: AnyObject {
    var viewController: CatalogСollectionViewControllerProtocol? { get set }
    var userURL: String? { get }
    var nftArray: [NFT] { get }
    func loadNFTs()
    func loadAuthorWebsite()
    func handleLikeButtonPressed(model: NFT)
    func handleCartButtonPressed(model: NFT)
}

// MARK: - Final Class

final class CatalogСollectionPresenter: CatalogСollectionPresenterProtocol {
    
    weak var viewController: CatalogСollectionViewControllerProtocol?
    private var dataProvider: CollectionDataProvider
    
    let nftModel: NFTCollection
    var userURL: String?
    var nftArray: [NFT] = []
    var profileModel: [ProfileModel] = []
    let cartController: CartControllerProtocol
    
    init(nftModel: NFTCollection, dataProvider: CollectionDataProvider, cartController: CartControllerProtocol) {
        self.nftModel = nftModel
        self.dataProvider = dataProvider
        self.cartController = cartController
    }
    
    private func prepareDataForShow(authorName: String) {
        let viewData = CatalogCollectionViewData(
            coverImageURL: nftModel.cover,
            title: nftModel.name,
            description: nftModel.description,
            authorName: authorName)
        viewController?.renderViewData(viewData: viewData)
    }
    
    func loadAuthorWebsite() {
        let id = nftModel.author
        dataProvider.getNFTCollectionAuthor(id: id) {  [weak self] result in
            self?.prepareDataForShow(authorName: result.name)
            self?.userURL = result.website
        }
    }
    
    func handleCartButtonPressed(model: NFT) {
        let isAddedToCart = cartController.cart.contains(where: { $0.id == model.id })
        if isAddedToCart {
            cartController.removeFromCart(model) {
                print("Removed from cart")}
        } else {
            cartController.addToCart(model) {
                print("Added to cart")
            }
        }
    }
    
    func handleLikeButtonPressed(model: NFT) {
        dataProvider.getUserProfile { [weak self] profileModel in
            let isLiked = profileModel.likes.contains { $0 == model.id }
            var updatedProfileModel = profileModel
            if isLiked {
                updatedProfileModel.likes.removeAll { $0 == model.id }
            } else {
                updatedProfileModel.likes.append(model.id)
            }
            self?.dataProvider.updateUserProfile(with: updatedProfileModel)
        }
    }
    
    func loadNFTs() {
        var nftArray: [NFT] = []
        let group = DispatchGroup()
        
        for nft in nftModel.nfts {
            group.enter()
            dataProvider.loadNFTsBy(id: nft) { [weak self] result in
                switch result {
                case .success(let data):
                    nftArray.append(data)
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        group.wait()
        group.notify(queue: .main) {
            self.nftArray = nftArray
            self.viewController?.reloadCollectionView()
        }
    }
}
