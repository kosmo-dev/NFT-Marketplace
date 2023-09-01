//
//  CartViewController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit
import Kingfisher

protocol CartViewControllerProtocol: AnyObject {
    func updatePayView(count: Int, price: String)
    func didDeleteNFT(for indexPath: IndexPath)
    func displayEmptyCart()
    func displayLoadedCart()
}

final class CartViewController: UIViewController {
    // MARK: - Private Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .whiteDayNight
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let payBackroundView: UIView = {
        let payBackroundView = UIView()
        payBackroundView.backgroundColor = .lightGreyDayNight
        payBackroundView.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]
        payBackroundView.layer.cornerRadius = 12
        payBackroundView.translatesAutoresizingMaskIntoConstraints = false
        return payBackroundView
    }()

    private let nftCounterLabel: UILabel = {
        let nftCounterLabel = UILabel()
        nftCounterLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nftCounterLabel.textColor = .blackDayNight
        nftCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        return nftCounterLabel
    }()

    private let totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        totalPriceLabel.textColor = .greenUni
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalPriceLabel
    }()

    private let toPaymentButton: CustomButton = {
        let toPaymentButton = CustomButton(
            type: .filled,
            title: TextStrings.CartViewController.toPaymentButton,
            action: #selector(toPaymentButtonTapped)
        )
        toPaymentButton.translatesAutoresizingMaskIntoConstraints = false
        return toPaymentButton
    }()

    private let deleteNFTView: DeleteNFTView = {
        let deleteNFTView = DeleteNFTView()
        deleteNFTView.translatesAutoresizingMaskIntoConstraints = false
        return deleteNFTView
    }()

    private let blurredView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        return blurredView
    }()

    private let emptyPlaceholderLabel: UILabel = {
        let emptyPlaceholderLabel = UILabel()
        emptyPlaceholderLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        emptyPlaceholderLabel.textColor = .blackDayNight
        emptyPlaceholderLabel.text = TextStrings.CartViewController.emptyCartLabel
        emptyPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        return emptyPlaceholderLabel
    }()

    private let sortNavigationButton = UIBarButtonItem(
        image: UIImage(named: "SortButton"),
        style: .plain,
        target: nil,
        action: #selector(sortButtonTapped)
    )

    private var presenter: CartPresenterProtocol

    // MARK: - Initializers
    init(presenter: CartPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        tableView.register(CartNFTCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        presenter.viewController = self
        deleteNFTView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        tableView.reloadData()
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteDayNight
        [tableView, payBackroundView, emptyPlaceholderLabel].forEach { view.addSubview($0) }
        [nftCounterLabel, totalPriceLabel, toPaymentButton].forEach { payBackroundView.addSubview($0) }

        sortNavigationButton.tintColor = .blackDayNight
        navigationController?.navigationBar.tintColor = .blackDayNight
        navigationItem.rightBarButtonItem = sortNavigationButton

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .whiteDayNight
            appearance.shadowColor = nil
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: payBackroundView.topAnchor),

            payBackroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            payBackroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            payBackroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            payBackroundView.heightAnchor.constraint(equalToConstant: 76),

            nftCounterLabel.topAnchor.constraint(equalTo: payBackroundView.topAnchor, constant: padding),
            nftCounterLabel.leadingAnchor.constraint(equalTo: payBackroundView.leadingAnchor, constant: padding),

            totalPriceLabel.topAnchor.constraint(equalTo: nftCounterLabel.bottomAnchor, constant: 2),
            totalPriceLabel.leadingAnchor.constraint(equalTo: nftCounterLabel.leadingAnchor),

            toPaymentButton.topAnchor.constraint(equalTo: payBackroundView.topAnchor, constant: padding),
            toPaymentButton.trailingAnchor.constraint(equalTo: payBackroundView.trailingAnchor, constant: -padding),
            toPaymentButton.bottomAnchor.constraint(equalTo: payBackroundView.bottomAnchor, constant: -padding),
            toPaymentButton.leadingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor, constant: 24),

            emptyPlaceholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyPlaceholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func toPaymentButtonTapped() {
        presenter.toPaymentButtonTapped()
    }

    @objc private func sortButtonTapped() {
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.nfts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartNFTCell = tableView.dequeueReusableCell()
        let nft = presenter.nfts[indexPath.row]
        let priceString = presenter.numberFormatter.string(from: NSNumber(value: nft.price)) ?? ""
        let cellModel = CartCellModel(
            id: nft.id, imageURL: nft.images[0], title: nft.name, price: "\(priceString) ETH", rating: nft.rating)
        cell.configureCell(cellModel)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: TextStrings.CartViewController.deleteButton) { [weak self] _, _, completionHandler in
            guard let self else { return }

            let nft = presenter.nfts[indexPath.row]
            deleteNFTButtonDidTapped(id: nft.id, imageURL: nft.images[0], returnHandler: completionHandler)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK: - CartViewControllerProtocol
extension CartViewController: CartViewControllerProtocol {
    func updatePayView(count: Int, price: String) {
        nftCounterLabel.text = "\(count) NFT"
        totalPriceLabel.text = "\(price) ETH"
    }

    func didDeleteNFT(for indexPath: IndexPath) {
        disableBlurEffect()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func displayEmptyCart() {
        tableView.isHidden = true
        payBackroundView.isHidden = true
        emptyPlaceholderLabel.isHidden = false
    }

    func displayLoadedCart() {
        tableView.isHidden = false
        payBackroundView.isHidden = false
        emptyPlaceholderLabel.isHidden = true
    }
}

// MARK: - CartNFTCellDelegate
extension CartViewController: CartNFTCellDelegate {
    func deleteNFTButtonDidTapped(id: String, imageURL: String, returnHandler: ((Bool) -> Void)?) {
        presenter.didSelectCellToDelete(id: id)
        deleteNFTView.setImage(imageURL)
        deleteNFTView.setReturnHandler(returnHandler)
        enableBlurEffect()
        blurredView.contentView.addSubview(deleteNFTView)
        NSLayoutConstraint.activate([
            deleteNFTView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteNFTView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func enableBlurEffect() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {

            blurredView.frame = window.bounds
            window.addSubview(blurredView)
        }
    }

    private func disableBlurEffect() {
        blurredView.removeFromSuperview()
        deleteNFTView.removeFromSuperview()
    }
}

// MARK: - DeleteNFTViewDelegate
extension CartViewController: DeleteNFTViewDelegate {
    func deleteButtonTapped() {
        presenter.deleteNFT()
    }

    func returnButtonTapped() {
        disableBlurEffect()
    }
}
