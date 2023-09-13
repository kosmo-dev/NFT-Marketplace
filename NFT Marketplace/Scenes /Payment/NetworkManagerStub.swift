//
//  NetworkManagerStub.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 13.09.2023.
//

import Foundation

final class NetworkManagerStub: NetworkManagerProtocol {
    func send<T>(request: NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        if let currencies = CurrencyMock.currencies as? T {
            completion(.success(currencies))
        }
    }

    func cancelAllLoadTasks() {

    }
}

struct CurrencyMock {
    static let currencies: [Currency] = [
        Currency(title: "aa", image: "", id: "1", ticker: "A"),
        Currency(title: "bb", image: "", id: "2", ticker: "B"),
        Currency(title: "cc", image: "", id: "3", ticker: "C")
    ]
}
