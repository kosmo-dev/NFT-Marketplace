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
}

// MARK: - Final Class

final class CatalogСollectionPresenter: CatalogСollectionPresenterProtocol {
    
    weak var viewController: CatalogСollectionViewControllerProtocol?
    private var dataProvider: CollectionDataProvider
    let nftModel: NFTCollection
    var userURL: String?
    var nftArray: [NFT] = []

    init(nftModel: NFTCollection, dataProvider: CollectionDataProvider) {
        self.nftModel = nftModel
        self.dataProvider = dataProvider
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
