//
//  SavingManager.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 15.09.2023.
//

import Foundation

protocol SavingManagerProtocol {
    func save<T>(value: T, for key: String)
    func getString(for key: String) -> String?
    func getBool(for key: String) -> Bool
}

struct SavingManager: SavingManagerProtocol {
    func save<T>(value: T, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func getString(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    func getBool(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

}
