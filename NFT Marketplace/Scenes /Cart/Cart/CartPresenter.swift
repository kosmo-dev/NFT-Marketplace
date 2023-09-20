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
    func viewDidLoad()
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

    private let savingManager = SavingManager()

    private var currentCartSortState = CartSortState.name.rawValue

    private var paymentFlowStarted = false

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
        if let savedSortState = savingManager.getString(for: Constants.cartSortStateKey) {
            currentCartSortState = savedSortState
        }
        createCellsModels()
        applySorting()
        checkNeedSwitchToCatalogVC()
    }

    func deleteNFT() {
        guard let choosedNFTId else { return }
        cartController.removeFromCart(choosedNFTId) { [weak self] in
            guard let self,
                  let index = self.cellsModels.firstIndex(where: { $0.id == choosedNFTId })
            else { return }
            self.checkViewState()
            self.cellsModels.remove(at: index)
            self.viewController?.didDeleteNFT(for: IndexPath(row: index, section: 0))
            self.viewController?.updatePayView(count: self.nfts.count, price: self.calculateTotalPrice())
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
        paymentFlowStarted = true
    }

    func sortButtonTapped() {
        let alerts = [
            AlertModel(title: TextLabels.CartViewController.sortByPrice, style: .default, completion: { [weak self] in
                self?.sortByPrice()
            }),
            AlertModel(title: TextLabels.CartViewController.sortByRating, style: .default, completion: { [weak self] in
                self?.sortByRating()
            }),
            AlertModel(title: TextLabels.CartViewController.sortByName, style: .default, completion: { [weak self] in
                self?.sortByNames()
            }),
            AlertModel(title: TextLabels.CartViewController.closeSorting, style: .cancel, completion: nil)
        ]
        viewController?.showAlertController(alerts: alerts)
    }

    func refreshTableViewCalled() {
        self.checkViewState()
        self.viewController?.reloadTableView()
    }

    func viewDidLoad() {
        let newCount = cartController.cart.count
        cartCountDidChanged(newCount)
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

    private func createCellsModels() {
        cellsModels.removeAll()
        for nft in nfts {
            let priceString = numberFormatter.string(from: NSNumber(value: nft.price)) ?? ""
            let cellModel = CartCellModel(
                id: nft.id, imageURL: nft.images.first ?? "", title: nft.name, price: "\(priceString) ETH", rating: nft.rating)
            cellsModels.append(cellModel)
        }
    }

    private func applySorting() {
        switch currentCartSortState {
        case CartSortState.name.rawValue:
            sortByNames()
        case CartSortState.rating.rawValue:
            sortByRating()
        case CartSortState.price.rawValue:
            sortByPrice()
        default:
            return
        }
    }

    private func sortByNames() {
        cellsModels.sort { $0.title < $1.title }
        currentCartSortState = CartSortState.name.rawValue
        didFinishSortCellsModels()
    }

    private func sortByRating() {
        cellsModels.sort { $0.rating > $1.rating }
        currentCartSortState = CartSortState.rating.rawValue
        didFinishSortCellsModels()
    }

    private func sortByPrice() {
        cellsModels.sort { $0.price < $1.price }
        currentCartSortState = CartSortState.price.rawValue
        didFinishSortCellsModels()
    }

    private func didFinishSortCellsModels() {
        viewController?.reloadTableView()
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self else { return }
            self.savingManager.save(value: self.currentCartSortState, for: Constants.cartSortStateKey)
        }
    }

    private func checkNeedSwitchToCatalogVC() {
        if paymentFlowStarted && cartController.cart.isEmpty {
            paymentFlowStarted = false
            viewController?.switchToCatalogVC()
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

// MARK: - CartControllerDelegate
extension CartPresenter: CartControllerDelegate {
    func cartCountDidChanged(_ newCount: Int) {
        let badgeValue = newCount > 0 ? String(newCount) : nil
        viewController?.updateTabBarItem(newValue: badgeValue)
    }
}

// MARK: - CartSortState
extension CartPresenter {
    enum CartSortState: String {
        case name
        case rating
        case price
    }
}

// MARK: - Constants
extension CartPresenter {
    enum Constants {
        static let cartSortStateKey = "cartSortStateKey"
    }
}
