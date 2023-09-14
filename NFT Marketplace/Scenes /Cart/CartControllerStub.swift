//
//  CartControllerStub.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 31.08.2023.
//

import Foundation

final class CartControllerStub: CartControllerProtocol {
    var delegate: CartControllerDelegate?

    var cart: [NFT] = [
        NFT(name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
            rating: 5, description: "", price: 1, author: "", id: "1", createdAt: ""),
        NFT(name: "Aurora", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
            rating: 4, description: "", price: 1.5, author: "", id: "2", createdAt: ""),
        NFT(name: "Bimbo", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
            rating: 3, description: "", price: 2, author: "", id: "3", createdAt: ""),
        NFT(name: "Biscuit", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Biscuit/1.png"],
            rating: 4, description: "", price: 2.5, author: "", id: "4", createdAt: ""),
        NFT(name: "Breena", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Breena/1.png"],
            rating: 1, description: "", price: 3, author: "", id: "5", createdAt: "")
    ]

    func addToCart(_ nft: NFT, completion: (() -> Void)?) {
        cart.append(nft)
        completion?()
    }

    func removeFromCart(_ nft: NFT, completion: (() -> Void)?) {
        guard let index = cart.firstIndex(where: { $0.id == nft.id }) else { return }
        cart.remove(at: index)
        completion?()
    }
}
