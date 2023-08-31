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
    // MARK: - Enumerations
    enum CartViewState {
        case empty
        case loaded
    }

    // MARK: - Public Properties
    var nfts: [NFT] {
        return cartController.cart
    }
    weak var viewController: CartViewControllerProtocol?

    // MARK: - Private Properties
    private let cartController: CartControllerProtocol

    private var choosedNFTId: String?
    private var choosedIndex: Int?

    private var currentState: CartViewState = .empty {
        didSet {
            viewControllerShouldChangeView()
        }
    }

    // MARK: - Initializers
    init(cartController: CartControllerProtocol) {
        self.cartController = cartController
    }

    // MARK: - Public Methods
    func viewWillAppear() {
        let count = nfts.count
        let totalPrice = calculateTotalPrice()
        viewController?.updatePayView(count: count, price: totalPrice)
        checkViewState()
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
            checkViewState()
        }
    }

    func didSelectCellToDelete(id: String) {
        choosedNFTId = id
        choosedIndex = nfts.firstIndex(where: { $0.id == id })
    }

    // MARK: - Private Methods
    private func calculateTotalPrice() -> Double {
        nfts.reduce(into: 0) { partialResult, nft in
            partialResult += nft.price
        }
    }

    private func viewControllerShouldChangeView() {
        switch currentState {
        case .empty:
            viewController?.displayEmptyCart()
        case .loaded:
            viewController?.displayLoadedCart()
        }
    }

    private func checkViewState() {
        if nfts.isEmpty {
            currentState = .empty
        } else {
            currentState = .loaded
        }
    }
}
