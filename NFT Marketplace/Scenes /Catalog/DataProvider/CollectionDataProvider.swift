//
//  CollectionDataProvider.swift
//  NFT Marketplace
//
//  Created by Dzhami on 10.09.2023.
//

import Foundation

// MARK: - Protocol

protocol  CollectionDataProviderProtocol: AnyObject {
    func getNFTCollectionAuthor(id: String, completion: @escaping (UserModel) -> Void)
    func loadNFTsBy(id: String, completion: @escaping (Result<NFT, Error>) -> Void)
}

// MARK: - final class

final class CollectionDataProvider: CollectionDataProviderProtocol {
    
    let networkClient: DefaultNetworkClient
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getNFTCollectionAuthor(id: String, completion: @escaping (UserModel) -> Void) {
        networkClient.send(request: UserByIdRequest(id: id), type: UserNetworkModel.self)  { [weak self] result in
            switch result {
            case .success(let data):
                completion(UserModel(with: data))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadNFTsBy(id: String, completion: @escaping (Result<NFT, Error>) -> Void) {
        networkClient.send(request: NFTGetRequest(id: id), type: NFT.self)  { [weak self] result in
            completion(result)
        }
    }
}
