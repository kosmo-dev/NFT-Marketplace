//
//  CatalogViewModel.swift
//  NFT Marketplace
//
//  Created by Dzhami on 28.08.2023.
//

import UIKit

// MARK: - Protocol

protocol CatalogPresenterProtocol: AnyObject {
    var dataSource: [NFTCollection] { get }
    var viewController: CatalogViewControllerProtocol? { get set }
    func fetchCollections()
    func sortNFTS(by: NFTCollectionsSortAttributes)
}

// MARK: - Final Class

final class CatalogPresenter: CatalogPresenterProtocol {

    weak var viewController: CatalogViewControllerProtocol?
    private var dataProvider: DataProviderProtocol

    var dataSource: [NFTCollection] {
        dataProvider.NFTCollections
    }

    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    func fetchCollections() {
        dataProvider.fetchNFTCollection { [weak self] in
            self?.viewController?.reloadTableView()
        }
    }

    func sortNFTS(by: NFTCollectionsSortAttributes) {
        dataProvider.sortNFTCollections(by: by)
    }
}
