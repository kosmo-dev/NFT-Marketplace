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
        button.setTitle(TextLabels.ProfileEditVC.saveButton, for: .normal)
        button.tintColor = .blackDayNight
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var userImage: UIImage?

    private lazy var profileAvatarView: ProfileEditUserPicture = {
        return ProfileEditUserPicture(frame: CGRect(x: 0, y: 0, width: 70, height: 70),
                                      image: userImage ?? UIImage(named: "profilePlaceholder"),
                                      text: TextLabels.ProfileEditVC.avatarLabel)
    }()

    private lazy var nameStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: TextLabels.ProfileEditVC.nameStackViewLabel,
                                         textContent: TextLabels.ProfileEditVC.nameStackViewContent)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var descriptionStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: TextLabels.ProfileEditVC.descriptionStackViewLabel,
                                         textContent: TextLabels.ProfileEditVC.descriptionStackViewContent)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var websiteStackView: ProfileEditStackView = {
        let stack = ProfileEditStackView(labelText: TextLabels.ProfileEditVC.websiteStackViewLabel,
                                         textContent: TextLabels.ProfileEditVC.websiteStackViewContent)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var scrollViewBottomConstrait: NSLayoutConstraint!

    var presenter: ProfileEditPresenterProtocol?
    weak var delegate: ProfileEditViewControllerDelegate?

    var currentUserProfile: UserProfile? {
        didSet {
            updateUIWithProfile()
        }
    }
    private let appMetricScreenName = "EditProfileScreen"
    private var updatedAvatar: UIImage?
    private let appMetrics: AppMetricsProtocol
    

    // MARK: - Initializer
    init(presenter: ProfileEditPresenterProtocol?, image: UIImage?, appMetrics: AppMetricsProtocol) {
        self.presenter = presenter
        self.userImage = image
        self.appMetrics = appMetrics
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDayNight
        profileAvatarView.delegate = self
        setupLayout()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification: )),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification: )),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textViewDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appMetrics.reportEvent(screen: appMetricScreenName, event: .open, item: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        appMetrics.reportEvent(screen: appMetricScreenName, event: .close, item: nil)
    }


    private func setupLayout() {
        [doneButton, profileAvatarView, nameStackView, descriptionStackView, websiteStackView].forEach {
            scrollView.addSubview($0)
        }
        view.addSubview(scrollView)

        profileAvatarView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewBottomConstrait = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        scrollViewBottomConstrait.isActive = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollViewBottomConstrait,
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doneButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
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
            websiteStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            websiteStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)

        ])

        // Добавляем распознаватель тапов для закрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func updateUIWithProfile() {
        guard let profile = currentUserProfile else { return }
        nameStackView.updateTextContent(profile.name)
        descriptionStackView.updateTextContent(profile.description)
        websiteStackView.updateTextContent(profile.website)
    }

    @objc func doneButtonTapped() {
        appMetrics.reportEvent(screen: appMetricScreenName, event: .click, item: .saveProfile)
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

    // MARK: - Methods for NSNotification

    @objc func keyboardWillShow(notification: NSNotification) {
        print("Показать")
        guard let keyboardSize = (notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardHeight = keyboardSize.height

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset

        // Сдвиг скрола на высоту клавиатуры
        var activeRect: CGRect?

        if nameStackView.textView.isFirstResponder {
            activeRect = nameStackView.frame
        } else if descriptionStackView.textView.isFirstResponder {
            activeRect = descriptionStackView.frame
        } else if websiteStackView.textView.isFirstResponder {
            activeRect = websiteStackView.frame
        }

        if let activeRect = activeRect {
            let rectInScrollView = scrollView.convert(activeRect, to: view)
            let offset = rectInScrollView.maxY - (view.bounds.height - keyboardHeight)
            let adjustedOffset = offset + 16
            if offset > 0 {
                scrollView.setContentOffset(CGPoint(x: 0, y: adjustedOffset), animated: true)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("Скрыть")
        scrollViewBottomConstrait.constant = 0
        view.layoutIfNeeded()
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    @objc func textViewDidChange(notification: NSNotification) {
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }

}

// MARK: - UIImagePickerControllerDelegate
extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        // MARK: - Depricated in future
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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
        appMetrics.reportEvent(screen: appMetricScreenName, event: .click, item: .changeAvatar)
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
        ProgressHUD.showSucceed(TextLabels.ProfileEditVC.profileUpdatedSuccesfully, delay: 2.0)
    }
}
