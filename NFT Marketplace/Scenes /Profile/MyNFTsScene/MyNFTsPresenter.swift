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

    init(profileService: NFTFetchingProtocol) {
        self.profileService = profileService
    }

    func viewDidLoad() {
        fetchNFT()
    }

    private func fetchNFT() {
        profileService.fetchNFTs(completion: { [weak self] result in
            switch result {
            case .success(let nfts):
                self?.nftModels = nfts
                self?.view?.updateWith(nfts: nfts)
            case .failure(let error):
                self?.view?.showError(error)
            }
        })
    }

}
