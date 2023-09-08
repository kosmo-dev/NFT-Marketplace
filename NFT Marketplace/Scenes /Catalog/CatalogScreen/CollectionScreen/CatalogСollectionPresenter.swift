//
//  CatalogСollectionPresenter.swift
//  NFT Marketplace
//
//  Created by Dzhami on 07.09.2023.
//

import Foundation

// MARK: - Protocol

protocol CatalogСollectionPresenterProtocol: AnyObject {
    func prepareDataForShow()
    var viewController: CatalogСollectionViewControllerProtocol? { get set }
}

// MARK: - Final Class

final class CatalogСollectionPresenter: CatalogСollectionPresenterProtocol {
    
    weak var viewController: CatalogСollectionViewControllerProtocol?
    let nftModel: NFTCollection
    
    init(nftModel: NFTCollection) {
        self.nftModel = nftModel
    }
    
    func prepareDataForShow() {
        let viewData = CatalogCollectionViewData(
            coverImageURL: nftModel.cover,
            title: nftModel.name,
            authorLink: nftModel.author,
            description: nftModel.description)
        viewController?.renderViewData(viewData: viewData)
    }
}
