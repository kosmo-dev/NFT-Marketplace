//
//  MyNFTsPresenter.swift
//  NFT Marketplace
//
//  Created by Денис on 05.09.2023.
//

import Foundation

final class MyNFTsPresenter {
    weak var view: MyNFTsViewProtocol?
    private let profileService: NFTFetchingProtocol

    var nftModels: [NFTModel] = []
    var nftIds: [String]

    init(nftIds: [String], profileService: NFTFetchingProtocol) {
        self.profileService = profileService
        self.nftIds = nftIds
    }

    func viewDidLoad() {
        fetchNFT()
    }

    private func fetchNFT() {
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

    func updateLikesArray(likes: [String]?) {

    }

}
