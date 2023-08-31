//
//  Strings.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//
// swiftlint:disable type_name

import Foundation

struct TextStrings {
    struct TabBarController {
        static let profileTabBarTitle = "Профиль"
        static let catalogTabBarTitle = "Каталог"
        static let cartTabBarTitle = "Корзина"
        static let statisticTabBarTitle = "Статистика"
    }

    struct CartNFTCell {
        static let priceDescription = "Цена"
    }

    struct CartViewController {
        static let toPaymentButton = "К оплате"
        static let deleteFromCartTitle = "Вы уверены, что хотите удалить объект из корзины?"
        static let deleteButton = "Удалить"
        static let returnButton = "Вернуться"
    }
}
