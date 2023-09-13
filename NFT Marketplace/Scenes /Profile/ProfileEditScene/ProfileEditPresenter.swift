//
//  ProfileEditPresenter.swift
//  NFT Marketplace
//
//  Created by Денис on 02.09.2023.
//

import Foundation
import UIKit

protocol ProfileEditPresenterProtocol: AnyObject {
    func updateProfile(name: String?, description: String?, website: String?)
}

protocol ProfileEditPresenterDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
}

final class ProfileEditPresenter: ProfileEditPresenterProtocol {

    private weak var view: ProfileEditViewProtocol?

    private var profileService: ProfileServiceProtocol

    weak var delegate: ProfileEditPresenterDelegate?

    init(view: ProfileEditViewProtocol, profileService: ProfileServiceProtocol) {
        self.view = view
        self.profileService = profileService
    }

    func updateProfile(name: String?, description: String?, website: String?) {
        view?.showLoadingState()

        let uploadModel = UploadProfileModel(name: name, description: description, website: website, likes: nil)
        profileService.updateUserProfile(with: uploadModel) { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.delegate?.profileDidUpdate(profile)
                    self?.view?.profileUpdateSuccessful()
                case .failure(let error):
                    self?.view?.displayError(error)
                    self?.view?.hideLoadingState()
                }
            }
        }
    }
}
