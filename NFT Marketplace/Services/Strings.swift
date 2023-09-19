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

    struct CartViewController {
        static let toPaymentButton = "К оплате"
        static let deleteFromCartTitle = "Вы уверены, что хотите удалить объект из корзины?"
        static let deleteButton = "Удалить"
        static let returnButton = "Вернуться"
        static let emptyCartLabel = "Корзина пуста"
        static let alertTitle = "Cортировка"
        static let alertMessage = "Выберите сортировку"
        static let sortByName = "По названию"
        static let sortByRating = "По рейтингу"
        static let sortByPrice = "По цене"
        static let closeSorting = "Закрыть"
    }

    struct CartNFTCell {
        static let priceDescription = "Цена"
    }

    struct PaymentViewController {
        static let navigationTitle = "Выберите способ оплаты"
        static let payButtonTitle = "Оплатить"
        static let payDescription = "Совершая покупку, вы соглашаетесь с условиями"
        static let userAgreementTitle = "Пользовательского соглашения"
    }

    struct PaymentConfirmationViewController {
        static let paymentConfirmed = "Успех! Оплата прошла, поздравляем с покупкой!"
        static let paymentFailed = "Упс! Что-то пошло не так :( Попробуйте еще раз!"
        static let returnButton = "Вернуться в каталог"
        static let tryAgainButton = "Попробовать еще раз"
    }

    struct CatalogVC {
        static let sorting = "Cортировка"
        static let sortByName = "По названию"
        static let sortByNFTCount = "По количеству NFT"
        static let close = "Закрыть"
    }

    struct CollectionVC {
        static let aboutAuthor = "Автор коллекции:"
    struct ProfileEditVC {
        static let avatarLabel: String = "Cменить\nфото"
        static let nameStackViewLabel: String = "Имя"
        static let nameStackViewContent: String = "Введите Ваше имя"
        static let descriptionStackViewLabel: String = "Описание"
        static let descriptionStackViewContent: String = "Введите Ваше описание"
        static let websiteStackViewLabel: String = "Сайт"
        static let websiteStackViewContent: String = "Введите Ваш Сайт"
        static let profileUpdatedSuccesfully: String = "Профиль успешно обновлен"
        static let saveButton: String = "Сохранить"
    }

    struct ProfileEditStackView {
        static let keyboardDoneButton: String = "Готово"
        static let keyboardResetButton: String = "Отменить ввод"
    }

    struct ProfileButtonsStackView {
        static let myNFTLabel: String = "Мои NFT"
        static let favoritesNFTLabel: String = "Избранные NFT"
        static let aboutDeveloperLabel: String = "О разработчике"
    }

    struct UserProfileStackView {
        static let userNameLabel: String = "Имя Пользователя"
        static let userInfoLabel: String = "Информация о Вас. Здесь может быть ваши данные или другую информацию."
        static let websiteLabel: String = "www.internet.com"
    }
    struct MyNFTsVC {

        static let navigationTitle: String = "Мои NFT"
        static let cellNFTPriceLabel: String = "Цена"
        static let alertTitleLabel: String = "Сортировка"
        static let alertPriceLabel = "По цене"
        static let alertRatingLabel = "По рейтингу"
        static let alertNameLabel = "По названию"
        static let alertCloseLabel = "Закрыть"
    }

    struct FavoritesNFTsVC {
        static let navigationTitle: String = "Избранные NFT"
    }

    struct AboutDevelopersVC {
        static let navigationTitle: String = "Команда разработчиков"
    }
}
