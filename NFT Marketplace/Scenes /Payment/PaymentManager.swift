//
//  PaymentManager.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 04.09.2023.
//

import Foundation

protocol PaymentManagerProtocol {
    var delegate: PaymentManagerDelegate? { get set }
    func performPayment(nfts: [String], currencyId: Int)
}

protocol PaymentManagerDelegate: AnyObject {
    func paymentFinishedWithError(_ error: Error)
    func paymentFinishedWithSuccess()
}

final class PaymentManager: PaymentManagerProtocol {
    var networkManager: NetworkManagerProtocol
    weak var delegate: PaymentManagerDelegate?

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func performPayment(nfts: [String], currencyId: Int) {
        sendPaymentRequest(currencyId: currencyId) { [weak self] result in
            guard let self else { return }

            if self.shouldContinuePaymentProcess(result: result) {
                putOrder(nfts: nfts) { result in
                    switch result {
                    case .success:
                        self.delegate?.paymentFinishedWithSuccess()
                    case .failure(let error):
                        self.delegate?.paymentFinishedWithError(error)
                    }
                }
            }
        }
    }

    private func sendPaymentRequest(currencyId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let request = OrderPayment(currencyId: currencyId)
        networkManager.send(request: request, type: OrderPaymentResponse.self, id: request.requestId) { result in
            switch result {
            case .success(let result):
                completion(.success(result.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func shouldContinuePaymentProcess(result: Result<Bool, Error>) -> Bool {
        switch result {
        case .success(let paymentSucceeded):
            if paymentSucceeded {
                return true
            } else {
                delegate?.paymentFinishedWithError(PaymentManagerError.paymentFailed)
                return false
            }
        case .failure(let error):
            delegate?.paymentFinishedWithError(error)
            return false
        }
    }

    private func putOrder(nfts: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        let request = OrderPut(nfts: nfts)
        networkManager.send(request: request, type: OrderResponse.self, id: request.requestId) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - PaymentManagerError
extension PaymentManager {
    enum PaymentManagerError: Error {
        case paymentFailed
    }
}
