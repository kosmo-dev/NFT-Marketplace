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
    var cellsModels: [CartCellModel] { get }

    func viewWillAppear()
    func deleteNFT()
    func didSelectCellToDelete(id: String)
    func toPaymentButtonTapped()
    func sortButtonTapped()
    func refreshTableViewCalled()
}

final class CartPresenter: CartPresenterProtocol {
    // MARK: - Public Properties
    weak var viewController: CartViewControllerProtocol?
    weak var navigationController: UINavigationController?
    var cellsModels: [CartCellModel] = []

    // MARK: - Private Properties
    private let cartController: CartControllerProtocol

    private var choosedNFTId: String?

    private var currentState: CartViewState = .empty {
        didSet {
            viewControllerShouldChangeView()
        }
    }

    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "ru_RU")
        return numberFormatter
    }()

    private var nfts: [NFT] {
        return cartController.cart
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
                  let index = cellsModels.firstIndex(where: { $0.id == choosedNFTId })
            else { return }
            checkViewState()
            self.viewController?.didDeleteNFT(for: IndexPath(row: index, section: 0))
            viewController?.updatePayView(count: nfts.count, price: calculateTotalPrice())
            self.choosedNFTId = nil
        }
    }

    func didSelectCellToDelete(id: String) {
        choosedNFTId = id
    }

    func toPaymentButtonTapped() {
        let networkClient = DefaultNetworkClient()
        let networkManager = NetworkManager(networkClient: networkClient)
        let paymentManager = PaymentManager(networkManager: networkManager)
        let presenter = PaymentPresenter(
            networkManager: networkManager,
            paymentManager: paymentManager,
            cartController: cartController)
        let viewController = PaymentViewController(presenter: presenter)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.pushViewController(viewController, animated: true)
    }

    func sortButtonTapped() {
        let alerts = [
            AlertModel(title: TextStrings.CartViewController.sortByPrice, style: .default, completion: { [weak self] in
                self?.sortByPrice()
            }),
            AlertModel(title: TextStrings.CartViewController.sortByRating, style: .default, completion: { [weak self] in
                self?.sortByRating()
            }),
            AlertModel(title: TextStrings.CartViewController.sortByName, style: .default, completion: { [weak self] in
                self?.sortByNames()
            })
        ]
        viewController?.showAlertController(alerts: alerts)
    }

    func refreshTableViewCalled() {
        self.checkViewState()
        self.viewController?.reloadTableView()
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
        createCellsModels()
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

    private func createCellsModels() {
        cellsModels.removeAll()
        for nft in nfts {
            let priceString = numberFormatter.string(from: NSNumber(value: nft.price)) ?? ""
            let cellModel = CartCellModel(
                id: nft.id, imageURL: nft.images[0], title: nft.name, price: "\(priceString) ETH", rating: nft.rating)
            cellsModels.append(cellModel)
        }
    }

    private func sortByNames() {
        cellsModels.sort { $0.title < $1.title }
        viewController?.reloadTableView()
    }

    private func sortByRating() {
        cellsModels.sort { $0.rating > $1.rating }
        viewController?.reloadTableView()
    }

    private func sortByPrice() {
        cellsModels.sort { $0.price < $1.price }
        viewController?.reloadTableView()
    }
}

// MARK: - CartViewState
extension CartPresenter {
    enum CartViewState {
        case empty
        case loaded
    }
}

// MARK: - CartControllerDelegate
extension CartPresenter: CartControllerDelegate {
    func cartCountDidChanged(_ newCount: Int) {
        let badgeValue = newCount > 0 ? String(newCount) : nil
        viewController?.updateTabBarItem(newValue: badgeValue)
    }
}
