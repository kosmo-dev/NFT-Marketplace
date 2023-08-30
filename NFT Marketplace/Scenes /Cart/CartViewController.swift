//
//  CartViewController.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

protocol CartViewControllerProtocol: AnyObject {
    func updatePayView(count: Int, price: Double)
    func didDeleteNFT(for indexPath: IndexPath)
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
            type: .filled, title: S.CartViewController.toPaymentButton, action: #selector(toPaymentButtonTapped)
        )
        toPaymentButton.translatesAutoresizingMaskIntoConstraints = false
        return toPaymentButton
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        tableView.reloadData()
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteDayNight
        [tableView, payBackroundView].forEach { view.addSubview($0) }
        [nftCounterLabel, totalPriceLabel, toPaymentButton].forEach { payBackroundView.addSubview($0) }

        sortNavigationButton.tintColor = .blackDayNight
        navigationController?.navigationBar.tintColor = .whiteDayNight
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
            toPaymentButton.leadingAnchor.constraint(equalTo: totalPriceLabel.trailingAnchor, constant: 24)
        ])
    }

    @objc private func toPaymentButtonTapped() {
        presenter.deleteNFT(presenter.nfts[1], indexPath: IndexPath(row: 1, section: 0))
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
        let cellViewModel = CartCellViewModel(
            imageURL: nft.images[0], title: nft.name, price: "\(nft.price) ETH", rating: nft.rating)
        cell.configureCell(cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - CartViewControllerProtocol
extension CartViewController: CartViewControllerProtocol {
    func updatePayView(count: Int, price: Double) {
        nftCounterLabel.text = "\(count)"
        totalPriceLabel.text = "\(price) ETH"
    }

    func didDeleteNFT(for indexPath: IndexPath) {
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
