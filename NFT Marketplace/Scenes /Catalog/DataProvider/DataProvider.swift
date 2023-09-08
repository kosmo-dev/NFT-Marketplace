//
//  DataProvider.swift
//  NFT Marketplace
//
//  Created by Dzhami on 29.08.2023.
//

import Foundation

// MARK: - Protocol

protocol DataProviderProtocol: AnyObject {
    func fetchNFTCollection(completion: @escaping () -> Void)
    func sortNFTCollections(by: NFTCollectionsSortAttributes)
    var NFTCollections: [NFTCollection] { get }
}

// MARK: - Final Class

final class DataProvider: DataProviderProtocol {
    
    var NFTCollections: [NFTCollection] = []
    let networkClient: DefaultNetworkClient
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchNFTCollection(completion: @escaping () -> Void) {
        networkClient.send(request: NFTTableViewRequest(), type: [NFTCollection].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let nft):
                NFTCollections = nft
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortNFTCollections(by: NFTCollectionsSortAttributes) {
        switch by {
        case .name:
            NFTCollections.sort { $0.name < $1.name }
        case .nftCount:
            NFTCollections.sort { $0.nftCount < $1.nftCount }
        }
    }
}
