//
//  Strings.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//
// swiftlint:disable type_name

import Foundation

struct S {
    struct TabBarController {
        static let profileTabBarTitle = "Профиль"
        static let catalogTabBarTitle = "Каталог"
        static let cartTabBarTitle = "Корзина"
        static let statisticTabBarTitle = "Статистика"
    }
    
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
        static let userInfoLabel: String = "Это информация о пользователе. Здесь может быть ваша биография, интересы или другая полезная информация."
        static let websiteLabel: String = "www.internet.com"
    }
}
