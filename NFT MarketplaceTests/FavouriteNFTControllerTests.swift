//
//  FavouriteNFTControllerTests.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import XCTest
@testable import NFT_Marketplace

final class FavouriteNFTTests: XCTestCase {

    let favouritesController = FavouriteNFTController()
    let nft1 = NFT(name: "nft1", images: [], rating: 0, description: "", price: 5, author: "", id: "1", createdAt: "")
    let nft2 = NFT(name: "nft2", images: [], rating: 0, description: "", price: 5, author: "", id: "2", createdAt: "")
    let nft3 = NFT(name: "nft3", images: [], rating: 0, description: "", price: 5, author: "", id: "3", createdAt: "")
    lazy var nfts = [nft1, nft2, nft3]

    func testAddNewNFT() {
        favouritesController.addToFavourite(nft1)
        XCTAssertEqual(favouritesController.favourites.count, 1)
    }

    func testRemoveNFT() {
        favouritesController.addToFavourite(nft1)
        favouritesController.addToFavourite(nft2)
        favouritesController.removeFromFavourite(nft1)
        XCTAssertEqual(favouritesController.favourites[0], nft2)
    }

    func testFavourites() {
        for nft in nfts {
            favouritesController.addToFavourite(nft)
        }
        XCTAssertEqual(favouritesController.favourites, nfts)
    }
}
