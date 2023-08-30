//
//  CartPresenter.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 31.08.2023.
//

import Foundation

protocol CartPresenterProtocol {
    var viewController: CartViewControllerProtocol? { get set }
    var nfts: [NFT] { get }

    func viewWillAppear()
    func deleteNFT(_ nft: NFT, indexPath: IndexPath)
}

final class CartPresenter: CartPresenterProtocol {
    var nfts: [NFT] {
        return cartController.cart
    }
    weak var viewController: CartViewControllerProtocol?

    private let cartController: CartControllerProtocol

    init(cartController: CartControllerProtocol) {
        self.cartController = cartController
    }

    func viewWillAppear() {
        let count = nfts.count
        let totalPrice = calculateTotalPrice()
        viewController?.updatePayView(count: count, price: totalPrice)
    }

    func deleteNFT(_ nft: NFT, indexPath: IndexPath) {
        cartController.removeFromCart(nft) { [weak self] in
            self?.viewController?.didDeleteNFT(for: indexPath)
        }
    }

    private func calculateTotalPrice() -> Double {
        nfts.reduce(into: 0) { partialResult, nft in
            partialResult += nft.price
        }
    }
}
