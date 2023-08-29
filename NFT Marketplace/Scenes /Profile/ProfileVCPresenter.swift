//
//  ProfileVCPresenter.swift
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
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    
    var profileService: ProfileServiceProtocol
    
    init(view: ProfileViewProtocol?, profileService: ProfileServiceProtocol) {
        self.view = view
        self.profileService = profileService
    }
    
    func viewDidLoad() {
        profileService.fetchUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self?.view?.updateUI(with: profile)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.displayError(error)
                }
            }
        }
    }
    
    func didTapEditProfile() {
        view?.navigateToEditProfileScreen()
    }
    
    func didTapMyNFTs() {
        
    }
    
    func didTapFavorites() {
        
    }
    
    func didTapAboutDeveloper() {
        
    }

    
}

