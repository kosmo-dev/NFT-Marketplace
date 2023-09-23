//
//  CartService.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import Foundation

final class CartService: CartControllerProtocol {
    weak var delegate: CartControllerDelegate?

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
    ///   - id: Id of NFT, to be removed from the cart
    ///   - completion: Optional: completion called when the NFT is removed from the cart.
    func removeFromCart(_ id: String, completion: (() -> Void)? = nil) {
        cartQueue.async(flags: .barrier) { [weak self] in
            guard let self,
                  let index = self._cart.firstIndex( where: { $0.id == id })
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

extension CartService {
    func removeAll(completion: (() -> Void)?) {
        cartQueue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            self._cart.removeAll()
            let cartCount = self._cart.count
            DispatchQueue.main.async {
                completion?()
                self.delegate?.cartCountDidChanged(cartCount)
            }
        }
    }
}
