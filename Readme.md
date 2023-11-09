# NFT Marketplace

[English Version of Readme](https://github.com/kosmo-dev/NFT-Marketplace/tree/Readme-update#english-version)

## Назначение и цели приложения ##

Приложение помогает пользователям просматривать и покупать NFT (Non-Fungible Token). Функционал покупки имитируется с помощью мокового сервера.

Цели приложения:

- просмотр коллекций NFT;
- просмотр и покупка NFT (имитируется);
- просмотр рейтинга других пользователей;
- просмотр профиля пользователя.

## Краткое описание приложения ##

- Приложение демонстрирует каталог NFT, структурированных в виде коллекций.
- Пользователь может посмотреть информацию о каталоге коллекций, выбранной коллекции и выбранном NFT.
- Пользователь может добавлять понравившиеся NFT в избранное.
- Пользователь может удалять и добавлять товары в корзину, а также оплачивать заказ (покупка имитируется).
- Пользователь может посмотреть рейтинг пользователей и информацию о пользователях.
- Пользователь может смотреть информацию и своем профиле, включая информацию об избранных и принадлежащих ему NFT.

Дополнительным функционалом являются:
- локализация
- тёмная тема
- экран онбординга
- алерт с предложением оценить приложение
- кастомный launch screen

## Стек технологий ##
- Swift, UIKit
- Архитектура: MVP
- Верстка кодом
- UITableView, UICollectionView, UITabBarController, WKWebView, UIPageController, UIScrollView
- URLSession
- Swift Package Manager
- GCD
- YandexMetrica
- Kingfisher
- Локализация
- Светлая / Темная тема

## Запись экранов с демонстрацией работы ##

**Эпик Профиль**

![Screenshot](ProfileEpicScreenCast.gif?raw=true)

**Эпик Каталог**

![Screenshot](CatalogEpicScreenCast.gif?raw=true)

**Эпик Корзина**

![Screenshot](CartEpicScreenCast.gif?raw=true)

**Эпик Статистика**

![Screenshot](StatisticsEpicScreenCast.gif?raw=true)

## Установка ##
Установка и запуск через Xcode. Требуемые зависимости закгружаются с помощью Swift Package Manager.

Минимальная версия системы iOS 14.0.

## Ссылки ##
[Дизайн Figma](https://www.figma.com/file/k1LcgXHGTHIeiCv4XuPbND/FakeNFT-(YP)?node-id=96-5542&t=YdNbOI8EcqdYmDeg-0)


# English Version

## Purpose and goals of the application ##

The app helps users browse and buy NFT (Non-Fungible Token). The purchasing functionality is simulated using a mock server.

Application goals:

- viewing NFT collections;
- viewing and purchasing NFT (simulated);
- viewing the ratings of other users;
- view the user profile.

## Description of the application ##
- The application show a catalog of NFTs structured as collections.
- The user can view information about the collection catalog, the selected collection and the selected NFT.
- The user can add NFTs to favorites.
- The user can remove and add items to the cart and place the order (the purchase is simulated).
- User can view other users' rating and users' information.
- The user can view his profile, including information about favorites and NFTs owned by him.

Additional functionality is:
- localization
- dark theme
- onboarding screen
- an alert with an offer to rate the app in the AppStore
- custom launch screen

  ## Technology stack ##
- Swift, UIKit
- Architecture: MVP
- Code layout
- UITableView, UICollectionView, UITabBarController, WKWebView, UIPageController, UIScrollView
- URLSession
- Swift Package Manager
- GCD
- YandexMetrica
- Kingfisher
- Localization
- Light/Dark theme

## Installation ##
Installation and launch via Xcode. Required dependencies are downloaded using Swift Package Manager.

Minimum system version is iOS 14.0.
