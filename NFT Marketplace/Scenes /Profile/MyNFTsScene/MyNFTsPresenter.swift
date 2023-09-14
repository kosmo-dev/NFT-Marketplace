//
//  MyNFTsPresenter.swift
//  NFT Marketplace
//
//  Created by Денис on 05.09.2023.
//

import Foundation

final class MyNFTsPresenter {
    weak var view: MyNFTsViewProtocol?
    private let profileService: ProfileServiceProtocol

    var nftModels: [NFTModel] = []
    var nftIds: [String]
    var likedNFTIds: [String]

    init(nftIds: [String], likedNFTIds: [String], profileService: ProfileServiceProtocol) {
        self.profileService = profileService
        self.nftIds = nftIds
        self.likedNFTIds = likedNFTIds
    }

    func viewDidLoad() {
        fetchUserNFT()
    }

    private func fetchUserNFT() {
        profileService.fetchNFTs(completion: { [weak self] result in
            switch result {
            case .success(let nfts):
                self?.nftModels = nfts.filter {self?.nftIds.contains($0.id) ?? false}
                self?.view?.updateWith(nfts: self?.nftModels ?? [])
            case .failure(let error):
                self?.view?.showError(error)
            }
        })
    }

    func toogleLike(forNFTWithId id: String) {
        if likedNFTIds.contains(id) {
            likedNFTIds.removeAll(where: {$0 == id})
        } else {
            likedNFTIds.append(id)
        }
        updateLikesArrayOnServer()
        view?.updateWith(nfts: nftModels)
    }

    private func updateLikesArrayOnServer() {
        let uploadModel = UploadProfileModel(name: nil,
                                             description: nil,
                                             website: nil,
                                             likes: likedNFTIds)
        profileService.updateUserProfile(with: uploadModel) { [weak self] result in
            switch result {
            case .success:
                print("Успех")
            case.failure(let error):
                print("\(error.localizedDescription)")
            }

        }
    }

}
