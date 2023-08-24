//
//  CartControllerProtocol.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import Foundation

protocol CartControllerProtocol {
    var delegate: CartControllerDelegate? { get set }
    var cart: [NFT] { get }

    func addToCart(_ nft: NFT, completion: (() -> Void)?)
    func removeFromCart(_ nft: NFT, completion: (() -> Void)?)
}

protocol CartControllerDelegate: AnyObject {
    func cartCountDidChanged(_ newCount: Int)
}
