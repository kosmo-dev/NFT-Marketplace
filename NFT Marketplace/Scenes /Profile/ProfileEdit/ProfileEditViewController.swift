//
//  ProfileEditViewController.swift
//  NFT Marketplace
//
//  Created by Денис on 31.08.2023.
//

import UIKit
import ProgressHUD
import Kingfisher

protocol ProfileEditViewProtocol: AnyObject {
    func showLoadingState()
    func hideLoadingState()
    func displayError(_ error: Error)
    func profileUpdateSuccessful()
}

protocol ProfileEditViewControllerDelegate: AnyObject {
    func didUpdateAvatar(_ newAvatar: UIImage)
}

final class ProfileEditViewController: UIViewController {
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(S.ProfileEditVC.saveButton, for: .normal)
        button.tintColor = .blackDayNight
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var userImage: UIImage?
    
    private lazy var profileAvatarView: ProfileEditUserPicture = {
        return ProfileEditUserPicture(frame: CGRect(x: 0, y: 0, width: 70, height: 70), image: userImage ?? UIImage(named: "Profile_placeholder"), text: S.ProfileEditVC.avatarLabel)
    }()
    
    private lazy var nameStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: S.ProfileEditVC.nameStackViewLabel,
                                         textContent: S.ProfileEditVC.nameStackViewContent)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var descriptionStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: S.ProfileEditVC.descriptionStackViewLabel,
                                         textContent: S.ProfileEditVC.descriptionStackViewContent)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var websiteStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: S.ProfileEditVC.websiteStackViewLabel,
                                         textContent: S.ProfileEditVC.websiteStackViewContent)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var presenter: ProfileEditPresenterProtocol?
    weak var delegate: ProfileEditViewControllerDelegate?
    
    
    var currentUserProfile: UserProfile? {
        didSet {
            updateUIWithProfile()
        }
    }
    
    private var updatedAvatar: UIImage?
    
    //MARK: -Initializer
    init(presenter: ProfileEditPresenterProtocol?, image: UIImage?) {
        self.presenter = presenter
        self.userImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        profileAvatarView.delegate = self
        setupLayout()
        // Добавляем распознаватель тапов для закрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupLayout() {
        [doneButton, profileAvatarView, nameStackView, descriptionStackView, websiteStackView].forEach { view.addSubview($0) }
        profileAvatarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileAvatarView.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 22),
            profileAvatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileAvatarView.widthAnchor.constraint(equalToConstant: 70),
            profileAvatarView.heightAnchor.constraint(equalToConstant: 70),
            nameStackView.topAnchor.constraint(equalTo: profileAvatarView.bottomAnchor, constant: 20),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 24),
            descriptionStackView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor),
            descriptionStackView.trailingAnchor.constraint(equalTo: nameStackView.trailingAnchor),
            websiteStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 24),
            websiteStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            websiteStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor)
        ])
    }
    
    private func updateUIWithProfile() {
        guard let profile = currentUserProfile else { return }
        nameStackView.updateTextContent(profile.name)
        descriptionStackView.updateTextContent(profile.description)
        websiteStackView.updateTextContent(profile.website)
    }
    
    
    @objc func doneButtonTapped() {
        let name = nameStackView.getTextContent()
        let description = descriptionStackView.getTextContent()
        let website = websiteStackView.getTextContent()
        presenter?.updateProfile(name: name, description: description, website: website)
        if let avatar = updatedAvatar {
            delegate?.didUpdateAvatar(avatar)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK: -UIImagePickerControllerDelegate
extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        //MARK: -Depricated in future
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileAvatarView.updateImage(selectedImage)
            updatedAvatar = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileEditViewController: ProfileEditUserPictureDelegate {
    func didTapTapOnImage() {
        openImagePicker()
    }
}

extension ProfileEditViewController: ProfileEditViewProtocol {
    func showLoadingState() {
        ProgressHUD.show()
    }
    
    func hideLoadingState() {
        ProgressHUD.dismiss()
    }
    
    func displayError(_ error: Error) {
        ProgressHUD.showError("\(error.localizedDescription)")
    }
    
    func profileUpdateSuccessful() {
        ProgressHUD.showSucceed(S.ProfileEditVC.profileUpdatedSuccesfully, delay: 2.0)
    }
}

