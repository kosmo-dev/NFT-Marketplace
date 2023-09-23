//
//  FavouriteNFTControllerProtocol.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import Foundation

protocol FavouriteNFTControllerProtocol {
    var favourites: [NFT] { get }

    func addToFavourite(_ nft: NFT, completion: (() -> Void)?)
    func removeFromFavourite(_ nft: NFT, completion: (() -> Void)?)
}

protocol FavouriteNFTControllerSaveProtocol {
    func savefavourites()
    func fetchFavourites(completion: () -> Void)
}
