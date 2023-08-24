//
//  CartControllerTests.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import XCTest
@testable import NFT_Marketplace

final class CartControllerTests: XCTestCase {

    let cartController = CartController()
    let nft1 = NFT(name: "nft1", images: [], rating: 0, description: "", price: 5, author: "", id: "1", createdAt: "")
    let nft2 = NFT(name: "nft2", images: [], rating: 0, description: "", price: 5, author: "", id: "2", createdAt: "")
    let nft3 = NFT(name: "nft3", images: [], rating: 0, description: "", price: 5, author: "", id: "3", createdAt: "")
    lazy var nfts = [nft1, nft2, nft3]

    func testAddNFT() {
        cartController.addToCart(nft1)
        XCTAssertEqual(cartController.cart.count, 1)
    }

    func testRemoveNFT() {
        cartController.addToCart(nft1)
        cartController.addToCart(nft2)
        cartController.removeFromCart(nft1)
        XCTAssertEqual(cartController.cart[0], nft2)
    }

    func testCart() {
        for nft in nfts {
            cartController.addToCart(nft)
        }
        XCTAssertEqual(cartController.cart, nfts)
    }
}
