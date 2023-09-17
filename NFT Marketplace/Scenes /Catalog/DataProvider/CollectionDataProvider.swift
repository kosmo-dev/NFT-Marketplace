//
//  CollectionDataProvider.swift
//  NFT Marketplace
//
//  Created by Dzhami on 10.09.2023.
//

import Foundation
import ProgressHUD

// MARK: - Protocol

protocol  CollectionDataProviderProtocol: AnyObject {
    func getNFTCollectionAuthor(id: String, completion: @escaping (UserModel) -> Void)
    func loadNFTsBy(id: String, completion: @escaping (Result<NFT, Error>) -> Void)
    func updateUserProfile (with profile: ProfileModel)
    func getUserProfile(completion: @escaping (ProfileModel) -> Void) 
}

// MARK: - final class

final class CollectionDataProvider: CollectionDataProviderProtocol {
    
    let networkClient: DefaultNetworkClient
    var profile: ProfileModel?
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getNFTCollectionAuthor(id: String, completion: @escaping (UserModel) -> Void) {
        ProgressHUD.show()
        networkClient.send(request: UserByIdRequest(id: id), type: UserNetworkModel.self)  { [weak self] result in
            switch result {
            case .success(let data):
                completion(UserModel(with: data))
            case .failure(let error):
                print(error)
            }
            ProgressHUD.dismiss()
        }
    }
    
    func loadNFTsBy(id: String, completion: @escaping (Result<NFT, Error>) -> Void) {
        ProgressHUD.show()
        networkClient.send(request: NFTGetRequest(id: id), type: NFT.self)  { [weak self] result in
            completion(result)
        }
        ProgressHUD.dismiss()
    }
    
    func updateUserProfile (with profile: ProfileModel) {
        networkClient.send(request: ProfileUpdateRequest(dto: profile)) {  [weak self] result in
            switch result {
            case .success(let data):
               print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserProfile(completion: @escaping (ProfileModel) -> Void) {
        networkClient.send(request: ProfileGetRequest(), type: ProfileModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
