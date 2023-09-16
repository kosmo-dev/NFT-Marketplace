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
    func updateCurrentUserProfile(with profile: UserProfile)
    var currentUserProfile: UserProfile? { get }
}

protocol ProfilePresenterDelegate: AnyObject {
    func shouldNavigateToMyNFTsScreen(with ids: [String], and likedIds: [String])
    func shouldNavigateTofavoriteNFTsScreen(with likedIds: [String])
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
        guard currentUserProfile == nil else {
            self.view?.updateUI(with: currentUserProfile!)
            return
        }

        profileService.fetchUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.currentUserProfile = profile
                    self?.view?.updateUI(with: profile)
                case .failure(let error):
                    self?.view?.displayError(error)
                }
            }
        }
    }

    func updateCurrentUserProfile(with profile: UserProfile) {
        currentUserProfile = profile
        view?.updateUI(with: profile)
    }

    func didTapEditProfile() {
        view?.navigateToEditProfileScreen()
    }

    func didTapMyNFTs() {
        let nftIds = getNFTIdsFromCurrentUser()
        let likedNFTIds = getLikedNFTIds()
        delegate?.shouldNavigateToMyNFTsScreen(with: nftIds, and: likedNFTIds)
    }

    func didTapFavorites() {
        let likedNFTIds = getLikedNFTIds()
        delegate?.shouldNavigateTofavoriteNFTsScreen(with: likedNFTIds)
    }

    func didTapAboutDeveloper() {

    }

}

extension ProfilePresenter {
    func getNFTIdsFromCurrentUser() -> [String] {
        return currentUserProfile?.nfts ?? []
    }

    func getLikedNFTIds() -> [String] {
        return currentUserProfile?.likes ?? []
    }
}
