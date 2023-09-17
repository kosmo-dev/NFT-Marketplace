//
//  Strings.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//
// 

import Foundation

struct TextLabels {
    struct TabBarController {
        static let profileTabBarTitle = "Профиль"
        static let catalogTabBarTitle = "Каталог"
        static let cartTabBarTitle = "Корзина"
        static let statisticTabBarTitle = "Статистика"
    }

    struct StatisticsVC {
        static let sortingTitle = "Cортировка"
        static let sortByNameTitle = "По имени"
        static let sortByRatingTitle = "По рейтингу"
        static let closeTitle = "Закрыть"
    }

    struct UserCardVC {
        static let userWebsiteButtonTitle = "Перейти на сайт пользователя"
        static let userCollectionsButtonTitle = "Коллекция NFT"
    }

    struct UsersCollectionVC {
        static let headerTitle = "Коллекция NFT"
    }

 struct CatalogVC {
        static let sorting = "Cортировка"
        static let sortByName = "По названию"
        static let sortByNFTCount = "По количеству NFT"
        static let close = "Закрыть"
    }

    struct CollectionVC {
        static let aboutAuthor = "Автор коллекции:"
    }
}
