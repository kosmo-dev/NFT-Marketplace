//
//  FavoritesNFTPresenter.swift
//  NFT Marketplace
//
//  Created by Денис on 06.09.2023.
//

import Foundation

final class FavoritesNFTPresenter {

    weak var view: FavoritesNFTView?
    private let profileService: ProfileServiceProtocol

    private var likedNFTIds: [String]
    var likedNFTs: [NFTModel] = []

    init(likedNFTIds: [String], profileService: ProfileServiceProtocol) {
        self.likedNFTIds = likedNFTIds
        self.profileService = profileService
    }

    func viewDidLoad() {
        fetchLikedNFTS()
    }

    private func fetchLikedNFTS() {
        profileService.fetchNFTs { [weak self] result in
            switch result {
            case .success(let nfts):
                print("Успешно получено \(nfts.count) NFTs.")
                let likedNFTs = nfts.filter { self?.likedNFTIds.contains($0.id) ?? false }
                self?.likedNFTs = likedNFTs
                print("После фильтрации осталось \(self?.likedNFTs.count ?? 0) NFTs.")
                self?.view?.updateNFTs(likedNFTs)
            case .failure(let error):
                self?.view?.showError(error)
            }
        }
    }

    func toggleLikeStatus(for nft: NFTModel) {
        if let index = likedNFTIds.firstIndex(of: nft.id) {
            likedNFTIds.remove(at: index)
            likedNFTs.removeAll { $0.id == nft.id}
        } else {
            likedNFTIds.append(nft.id)
            likedNFTs.append(nft)
        }
        view?.updateNFTs(likedNFTs)
        updateLikesArrayOnServer()
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
