//
//  Strings.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//


import Foundation

struct TextLabels {
    struct OnboardingVC {
        static var firstHeader: String {
            return NSLocalizedString("firstHeader", comment: "")
        }
        static var firstDescription: String {
            return NSLocalizedString("firstDescription", comment: "")
        }
        static var secondHeader: String {
            return NSLocalizedString("secondHeader", comment: "")
        }
        static var secondDescription: String {
            return NSLocalizedString("secondDescription", comment: "")
        }
        static var thirdHeader: String {
            return NSLocalizedString("thirdHeader", comment: "")
        }
        static var thirdDescription: String {
            return NSLocalizedString("thirdDescription", comment: "")
        }
        static var onboardingButton: String {
            return NSLocalizedString("onboardingButton", comment: "")
        }
    }
    
    struct TabBarController {
        static var profileTabBarTitle: String {
            return NSLocalizedString("profileTabBarTitle", comment: "")
        }
        static var catalogTabBarTitle: String {
            return NSLocalizedString("catalogTabBarTitle", comment: "")
        }
        static var cartTabBarTitle: String {
            return NSLocalizedString("cartTabBarTitle", comment: "")
        }
        static var statisticTabBarTitle: String {
            return NSLocalizedString("statisticTabBarTitle", comment: "")
        }
    }

    struct ProfileEditVC {
        static var avatarLabel: String {
            return NSLocalizedString("avatarLabel", comment: "")
        }
        static var nameStackViewLabel: String {
            return NSLocalizedString("nameStackViewLabel", comment: "")
        }
        static var nameStackViewContent: String {
            return NSLocalizedString("nameStackViewContent", comment: "")
        }
        static var descriptionStackViewLabel: String {
            return NSLocalizedString("descriptionStackViewLabel", comment: "")
        }
        static var descriptionStackViewContent: String {
            return NSLocalizedString("descriptionStackViewContent", comment: "")
        }
        static var websiteStackViewLabel: String {
            return NSLocalizedString("websiteStackViewLabel", comment: "")
        }
        static var websiteStackViewContent: String {
            return NSLocalizedString("websiteStackViewContent", comment: "")
        }
        static var profileUpdatedSuccesfully: String {
            return NSLocalizedString("profileUpdatedSuccessfully", comment: "")
        }
        static var saveButton: String {
            return NSLocalizedString("saveButton", comment: "")
        }
    }

    struct ProfileEditStackView {
        static var keyboardDoneButton: String {
            return NSLocalizedString("keyboardDoneButton", comment: "")
        }
        static var keyboardResetButton: String {
            return NSLocalizedString("keyboardResetButton", comment: "")
        }
    }

    struct ProfileButtonsStackView {
        static var myNFTLabel: String {
            return NSLocalizedString("myNFTLabel", comment: "")
        }
        static var favoritesNFTLabel: String {
            return NSLocalizedString("favoritesNFTLabel", comment: "")
        }
        static var aboutDeveloperLabel: String {
            return NSLocalizedString("aboutDeveloperLabel", comment: "")
        }
    }

    struct UserProfileStackView {
        static var userNameLabel: String {
            return NSLocalizedString("userNameLabel", comment: "")
        }
        static var userInfoLabel: String {
            return NSLocalizedString("userInfoLabel", comment: "")
        }
        static var websiteLabel: String {
            return NSLocalizedString("websiteLabel", comment: "")
        }
    }

    struct MyNFTsVC {
        static var navigationTitle: String {
            return NSLocalizedString("myNFTsNavigationTitle", comment: "")
        }
        static var cellNFTPriceLabel: String {
            return NSLocalizedString("cellNFTPriceLabel", comment: "")
        }
        static var alertTitleLabel: String {
            return NSLocalizedString("alertTitleLabel", comment: "")
        }
        static var alertPriceLabel: String {
            return NSLocalizedString("alertPriceLabel", comment: "")
        }
        static var alertRatingLabel: String {
            return NSLocalizedString("alertRatingLabel", comment: "")
        }
        static var alertNameLabel: String {
            return NSLocalizedString("alertNameLabel", comment: "")
        }
        static var alertCloseLabel: String {
            return NSLocalizedString("alertCloseLabel", comment: "")
        }
        static var placeholder: String {
            return NSLocalizedString("myNFTsPlaceholder", comment: "")
        }
    }

    struct FavoritesNFTsVC {
        static var navigationTitle: String {
            return NSLocalizedString("favoritesNFTsNavigationTitle", comment: "")
        }
        static var placeholder: String {
            return NSLocalizedString("favoritesNFTsPlaceholder", comment: "")
        }
    }

    struct AboutDevelopersVC {
        static var navigationTitle: String {
            return NSLocalizedString("aboutDevelopersNavigationTitle", comment: "")
        }
    }
    
    struct StatisticsVC {
        static var sortingTitle: String {
            return NSLocalizedString("statisticsSortingTitle", comment: "")
        }
        static var sortByNameTitle: String {
            return NSLocalizedString("sortByNameTitle", comment: "")
        }
        static var sortByRatingTitle: String {
            return NSLocalizedString("sortByRatingTitle", comment: "")
        }
        static var closeTitle: String {
            return NSLocalizedString("statisticsCloseTitle", comment: "")
        }
    }

    struct UserCardVC {
        static var userWebsiteButtonTitle: String {
            return NSLocalizedString("userWebsiteButtonTitle", comment: "")
        }
        static var userCollectionsButtonTitle: String {
            return NSLocalizedString("userCollectionsButtonTitle", comment: "")
        }
    }

    struct UsersCollectionVC {
        static var headerTitle: String {
            return NSLocalizedString("usersCollectionHeaderTitle", comment: "")
        }
    }

    struct CartViewController {
        static var toPaymentButton: String {
            return NSLocalizedString("toPaymentButton", comment: "")
        }
        static var deleteFromCartTitle: String {
            return NSLocalizedString("deleteFromCartTitle", comment: "")
        }
        static var deleteButton: String {
            return NSLocalizedString("deleteButton", comment: "")
        }
        static var returnButton: String {
            return NSLocalizedString("returnButton", comment: "")
        }
        static var emptyCartLabel: String {
            return NSLocalizedString("emptyCartLabel", comment: "")
        }
        static var alertTitle: String {
            return NSLocalizedString("cartAlertTitle", comment: "")
        }
        static var alertMessage: String {
            return NSLocalizedString("cartAlertMessage", comment: "")
        }
        static var sortByName: String {
            return NSLocalizedString("sortByName", comment: "")
        }
        static var sortByRating: String {
            return NSLocalizedString("sortByRating", comment: "")
        }
        static var sortByPrice: String {
            return NSLocalizedString("sortByPrice", comment: "")
        }
        static var closeSorting: String {
            return NSLocalizedString("closeSorting", comment: "")
        }
    }

    struct CartNFTCell {
        static var priceDescription: String {
            return NSLocalizedString("cartNFTCellPriceDescription", comment: "")
        }
    }

    struct PaymentViewController {
        static var navigationTitle: String {
            return NSLocalizedString("paymentNavigationTitle", comment: "")
        }
        static var payButtonTitle: String {
            return NSLocalizedString("payButtonTitle", comment: "")
        }
        static var payDescription: String {
            return NSLocalizedString("payDescription", comment: "")
        }
        static var userAgreementTitle: String {
            return NSLocalizedString("userAgreementTitle", comment: "")
        }
    }

    struct PaymentConfirmationViewController {
        static var paymentConfirmed: String {
            return NSLocalizedString("paymentConfirmed", comment: "")
        }
        static var paymentFailed: String {
            return NSLocalizedString("paymentFailed", comment: "")
        }
        static var returnButton: String {
            return NSLocalizedString("returnCatalogButton", comment: "")
        }
        static var tryAgainButton: String {
            return NSLocalizedString("tryAgainButton", comment: "")
        }
    }

    struct CatalogVC {
        static var sorting: String {
            return NSLocalizedString("catalogSorting", comment: "")
        }
        static var sortByName: String {
            return NSLocalizedString("catalogSortByName", comment: "")
        }
        static var sortByNFTCount: String {
            return NSLocalizedString("catalogSortByNFTCount", comment: "")
        }
        static var close: String {
            return NSLocalizedString("catalogClose", comment: "")
        }
    }

    struct CollectionVC {
        static var aboutAuthor: String {
            return NSLocalizedString("collectionAboutAuthor", comment: "")
        }
    }
}
