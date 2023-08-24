//
//  CartController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import Foundation

final class CartController: CartControllerProtocol {
    var delegate: CartControllerDelegate?

    private var _cart: [NFT] = []
    private let cartQueue = DispatchQueue(label: "com.nftMarketplace.cartQueue", attributes: .concurrent)

    /// Array of NFTs added to cart
    var cart: [NFT] {
        return cartQueue.sync { _cart }
    }

    /// Adds NFT to cart
    /// - Parameters:
    ///   - nft: NFT to add to cart
    ///   - completion: Optional: completion called when the NFT is added to the cart
    func addToCart(_ nft: NFT, completion: (() -> Void)? = nil) {
        cartQueue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            self._cart.append(nft)
            let cartCount = self._cart.count
            DispatchQueue.main.async {
                completion?()
                self.delegate?.cartCountDidChanged(cartCount)
            }
        }
    }

    /// Removes NFT from cart
    /// - Parameters:
    ///   - nft: NFT, to be removed from the cart
    ///   - completion: Optional: completion called when the NFT is removed from the cart.
    func removeFromCart(_ nft: NFT, completion: (() -> Void)? = nil) {
        cartQueue.async(flags: .barrier) { [weak self] in
            guard let self,
                  let index = self._cart.firstIndex(of: nft)
            else { return }
            self._cart.remove(at: index)
            let cartCount = self._cart.count
            DispatchQueue.main.async {
                completion?()
                self.delegate?.cartCountDidChanged(cartCount)
            }
        }
    }
}
