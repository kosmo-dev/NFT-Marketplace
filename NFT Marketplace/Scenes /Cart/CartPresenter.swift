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
    func deleteNFT()
    func didSelectCellToDelete(id: String)
}

final class CartPresenter: CartPresenterProtocol {
    var nfts: [NFT] {
        return cartController.cart
    }
    weak var viewController: CartViewControllerProtocol?

    private let cartController: CartControllerProtocol

    private var choosedNFTId: String?
    private var choosedIndex: Int?

    init(cartController: CartControllerProtocol) {
        self.cartController = cartController
    }

    func viewWillAppear() {
        let count = nfts.count
        let totalPrice = calculateTotalPrice()
        viewController?.updatePayView(count: count, price: totalPrice)
    }

    func deleteNFT() {
        guard let choosedNFTId else { return }
        cartController.removeFromCart(choosedNFTId) { [weak self] in
            guard let self,
                  let index = self.choosedIndex else { return }
            self.viewController?.didDeleteNFT(for: IndexPath(row: index, section: 0))
            viewController?.updatePayView(count: nfts.count, price: calculateTotalPrice())
            self.choosedIndex = nil
            self.choosedNFTId = nil
        }
    }

    func didSelectCellToDelete(id: String) {
        choosedNFTId = id
        choosedIndex = nfts.firstIndex(where: { $0.id == id })
    }

    private func calculateTotalPrice() -> Double {
        nfts.reduce(into: 0) { partialResult, nft in
            partialResult += nft.price
        }
    }
}
