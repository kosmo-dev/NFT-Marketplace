//
//  StoreRatingService.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 20.09.2023.
//

import Foundation

struct StoreRatingService {
    private let savingManager = SavingManager()

    func checkNeedShowRating() -> Bool {
        let storeRatingViewDidShow = savingManager.getBool(for: Constants.storeRatingViewDidShowed)
        guard !storeRatingViewDidShow else { return false }
        savingManager.save(value: true, for: Constants.storeRatingViewDidShowed)
        return true
    }
}

extension StoreRatingService {
    enum Constants {
        static let storeRatingViewDidShowed = "storeRatingViewDidShowed"
    }
}
