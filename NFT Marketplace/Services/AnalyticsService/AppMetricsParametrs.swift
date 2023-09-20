//
//  AppMetricsParametrs.swift
//  NFT Marketplace
//
//  Created by Денис on 20.09.2023.
//

import Foundation

enum AppMetricsParams {
    enum Item: String {
        //Экран Редактирования профиля
        ///Пользователь сохраняет изменения
        case saveProfile
        ///Пользователь изменяет аватарку
        case changeAvatar
       
        //Экран Мои NFT
        case myNFTFilter
        
        //Экран Каталог
        case catalogFilter
        
        //Экран Корзина
        case cartFilter
        case userAgreementTapped
        
        //Экран Статистики
        case statisticFilter
    }
    
    enum Event: String {
        ///Открытие нового экрана
        case open
        ///Закрытие  прежнего экрана
        case close
        ///Обработка нажатия на кликабельный объект
        case click
    }
}
