//
//  ProfilePresenter.swift
//  NFT Marketplace
//
//  Created by Денис on 28.08.2023.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapEditProfile()
    func didTapMyNFTs()
    func didTapFavorites()
    func didTapAboutDeveloper()
    var currentUserProfile: UserProfile? { get }
}

protocol ProfilePresenterDelegate: AnyObject {
    func shouldNavigateToMyNFTsScreen(with ids: [String])
}

class ProfilePresenter: ProfilePresenterProtocol {

    weak var delegate: ProfilePresenterDelegate?
    weak var view: ProfileViewProtocol?
    var profileService: ProfileServiceProtocol

    private(set) var currentUserProfile: UserProfile?

    init(view: ProfileViewProtocol?, profileService: ProfileServiceProtocol) {
        self.view = view
        self.profileService = profileService
    }

    func viewDidLoad() {
        profileService.fetchUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.currentUserProfile = profile
                    self?.view?.updateUI(with: profile)
//                    if let nftIds = self?.getNFTIdsFromCurrentUser() {
//                        self?.delegate?.shouldNavigateToMyNFTsScreen(with: nftIds)
//                    }
                case .failure(let error):
                    self?.view?.displayError(error)
                }
            }
        }
    }

    func didTapEditProfile() {
        view?.navigateToEditProfileScreen()
    }

    func didTapMyNFTs() {
        let nftIds = getNFTIdsFromCurrentUser()
        if !nftIds.isEmpty {
            print("Переход")
            delegate?.shouldNavigateToMyNFTsScreen(with: nftIds)
        } else {
            print("ошибка")
            return
        }
    }

    func didTapFavorites() {

    }

    func didTapAboutDeveloper() {

    }

}

extension ProfilePresenter {
    func getNFTIdsFromCurrentUser() -> [String] {
        return currentUserProfile?.nfts ?? []
    }
}
