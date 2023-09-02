//
//  PaymentPresenter.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import UIKit

protocol PaymentPresesnterProtocol {
    var currenciesCellModel: [CurrencyCellModel] { get }
    var viewController: PaymentViewControllerProtocol? { get set }

    func viewDidLoad()
    func didSelectItemAt(_ indexPath: IndexPath)
}

final class PaymentPresenter: PaymentPresesnterProtocol {
    // MARK: - Public Properties
    weak var viewController: PaymentViewControllerProtocol?
    var currenciesCellModel: [CurrencyCellModel] = []

    // MARK: - Private Properties
    private let networkManager: NetworkManagerProtocol
    private var currentState: PaymentViewState? {
        didSet {
            viewControllerShouldChangeView()
        }
    }
    private var currencies: [Currency] = []
    private var seletedItemIndexPath: IndexPath?

    // MARK: - Initializers
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    // MARK: - Public Methods
    func viewDidLoad() {
        checkState()
        fetchCurrencies()
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        seletedItemIndexPath = indexPath
        makeCurrenciesCellModel()
        viewController?.reloadCollectionView()
    }

    // MARK: - Private Methods
    private func fetchCurrencies() {
        let request = CurrenciesRequest()
        networkManager.send(request: request, type: [Currency].self, id: request.requestId) { result in
            switch result {
            case .success(let currencies):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.currencies = currencies
                    self.makeCurrenciesCellModel()
                    self.checkState()
                    self.viewController?.reloadCollectionView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func checkState() {
        if currencies.isEmpty {
            currentState = .loading
        } else {
            currentState = .loaded
        }
    }

    private func viewControllerShouldChangeView() {
        guard let currentState else { return }

        switch currentState {
        case .loading:
            viewController?.displayLoadingIndicator()
        case .loaded:
            viewController?.removeLoadingIndicator()
        }
    }

    private func makeCurrenciesCellModel() {
        currenciesCellModel.removeAll()
        for (index, currency) in currencies.enumerated() {
            let isSelected = index == seletedItemIndexPath?.row ? true : false
            let model = CurrencyCellModel(
                imageURL: currency.image,
                title: currency.title,
                ticker: currency.ticker,
                isSelected: isSelected)
            currenciesCellModel.append(model)
        }
    }
}

// MARK: - PaymentViewState
extension PaymentPresenter {
    enum PaymentViewState {
        case loading
        case loaded
    }
}
