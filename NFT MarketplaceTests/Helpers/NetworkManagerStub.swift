//
//  NetworkManagerStub.swift
//  NFT MarketplaceTests
//
//  Created by Вадим Кузьмин on 02.09.2023.
//

import Foundation
@testable import NFT_Marketplace

final class NetworkManagerStub: NetworkManagerProtocol {
    func send<T>(request: NFT_Marketplace.NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        if let currencies = CurrencyMock.currencies as? T {
            completion(.success(currencies))
        }
    }

    func cancelAllLoadTasks() {}
}
