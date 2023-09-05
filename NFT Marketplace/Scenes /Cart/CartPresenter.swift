//
//  CartPresenter.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 31.08.2023.
//

import UIKit

protocol CartPresenterProtocol {
    var viewController: CartViewControllerProtocol? { get set }
    var navigationController: UINavigationController? { get set }
    var nfts: [NFT] { get }
    var numberFormatter: NumberFormatter { get }

    func viewWillAppear()
    func deleteNFT()
    func didSelectCellToDelete(id: String)
    func toPaymentButtonTapped()
}

final class CartPresenter: CartPresenterProtocol {
    // MARK: - Public Properties
    var nfts: [NFT] {
        return cartController.cart
    }
    weak var viewController: CartViewControllerProtocol?
    weak var navigationController: UINavigationController?

    // MARK: - Private Properties
    private let cartController: CartControllerProtocol

    private var choosedNFTId: String?
    private var choosedIndex: Int?

    private var currentState: CartViewState = .empty {
        didSet {
            viewControllerShouldChangeView()
        }
    }

    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "ru_RU")
        return numberFormatter
    }()

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

    func toPaymentButtonTapped() {
        let networkClient = DefaultNetworkClient()
        let networkManager = NetworkManager(networkClient: networkClient)
        let presenter = PaymentPresenter(networkManager: networkManager)
        let viewController = PaymentViewController(presenter: presenter)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Private Methods
    private func calculateTotalPrice() -> String {
        let price = nfts.reduce(into: 0) { partialResult, nft in
            partialResult += nft.price
        }
        let number = NSNumber(value: price)
        let formatted = numberFormatter.string(from: number) ?? ""
        return formatted
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

// MARK: - CartViewState
extension CartPresenter {
    enum CartViewState {
        case empty
        case loaded
    }
}
