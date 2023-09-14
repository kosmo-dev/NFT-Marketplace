//
//  PaymentPresenter.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import UIKit
import SafariServices

protocol PaymentPresenterProtocol {
    var currenciesCellModel: [CurrencyCellModel] { get }
    var viewController: PaymentViewControllerProtocol? { get set }

    func viewDidLoad()
    func didSelectItemAt(_ indexPath: IndexPath)
    func userAgreementButtonTapped()
    func payButtonTapped()
}

final class PaymentPresenter: PaymentPresenterProtocol {
    // MARK: - Public Properties
    weak var viewController: PaymentViewControllerProtocol?
    var currenciesCellModel: [CurrencyCellModel] = []

    // MARK: - Private Properties
    private let networkManager: NetworkManagerProtocol
    private var paymentManager: PaymentManagerProtocol
    private let cartController: CartControllerProtocol
    private var currentState: PaymentViewState? {
        didSet {
            viewControllerShouldChangeView()
        }
    }
    private var currencies: [Currency] = []
    private var seletedItemIndexPath: IndexPath?
    private var currencyId: Int? {
        guard let seletedItemIndexPath else { return nil }
        return Int(currencies[seletedItemIndexPath.row].id)
    }
    private var payButtonState: PayButtonState? {
        didSet {
            viewControllerShouldChnangeButtonAppearance()
        }
    }
    private var paymentIsSucceeded: Bool?

    // MARK: - Initializers
    init(networkManager: NetworkManagerProtocol,
         paymentManager: PaymentManagerProtocol,
         cartController: CartControllerProtocol) {
        self.networkManager = networkManager
        self.paymentManager = paymentManager
        self.cartController = cartController
        self.paymentManager.delegate = self
    }

    // MARK: - Public Methods
    func viewDidLoad() {
        checkState()
        payButtonState = .disabled
        fetchCurrencies()
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        seletedItemIndexPath = indexPath
        makeCurrenciesCellModel()
        viewController?.reloadCollectionView()
        payButtonState = .enabled
    }

    func userAgreementButtonTapped() {
        guard let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") else { return }
        let safariViewController = SFSafariViewController(url: url)
        viewController?.presentView(safariViewController)
    }

    func payButtonTapped() {
        guard let currencyId else { return }
        let nfts = getNFTSIds()
        payButtonState = .loading
        paymentManager.performPayment(nfts: nfts, currencyId: currencyId)
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

    private func getNFTSIds() -> [String] {
        var ids: [String] = []
        for nft in cartController.cart {
            ids.append(nft.id)
        }
        return ids
    }

    private func viewControllerShouldChnangeButtonAppearance() {
        guard let payButtonState else { return }
        switch payButtonState {
        case .disabled:
            viewController?.changeButtonState(color: .greyUni, isEnabled: false, isLoading: false)
        case .enabled:
            viewController?.changeButtonState(color: .blackDayNight, isEnabled: true, isLoading: false)
        case .loading:
            viewController?.changeButtonState(color: .blackDayNight, isEnabled: false, isLoading: true)
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

// MARK: - PaymentManagerDelegate
extension PaymentPresenter: PaymentManagerDelegate {
    func paymentFinishedWithError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            let presenter = PaymentConfirmationPresenter(configuration: .failure)
            presenter.delegate = self
            let confirmationViewController = PaymentConfirmationViewController(presenter: presenter)
            confirmationViewController.modalPresentationStyle = .fullScreen
            self?.viewController?.presentView(confirmationViewController)
            self?.payButtonState = .enabled
            self?.paymentIsSucceeded = false
        }
    }

    func paymentFinishedWithSuccess() {
        DispatchQueue.main.async { [weak self] in
            let presenter = PaymentConfirmationPresenter(configuration: .success)
            presenter.delegate = self
            let confirmationViewController = PaymentConfirmationViewController(presenter: presenter)
            confirmationViewController.modalPresentationStyle = .fullScreen
            self?.viewController?.presentView(confirmationViewController)
            self?.payButtonState = .enabled
            self?.paymentIsSucceeded = true
        }
    }
}

// MARK: - PayButtonState
extension PaymentPresenter {
    enum PayButtonState {
        case disabled
        case enabled
        case loading
    }
}

extension PaymentPresenter: PaymentConfirmationPresenterDelegate {
    func didTapDismissButton() {
        viewController?.dismiss()
        guard let paymentIsSucceeded,
        paymentIsSucceeded else { return }
        cartController.removeAll { [weak self] in
            self?.viewController?.popToRootViewController(animated: true)
        }
    }
}
