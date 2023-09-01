//
//  Strings.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

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
        static let emptyCartLabel = "Корзина пуста"
    }

    struct PaymentViewController {
        static let navigationTitle = "Выберите способ оплаты"
        static let payButtonTitle = "Оплатить"
        static let payDescription = "Совершая покупку, вы соглашаетесь с условиями"
        static let userAgreementTitle = "Пользовательского соглашения"
    }
}
