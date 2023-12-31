//
//  StatisticsViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 27.08.2023.
//

import UIKit

protocol StatisticsViewControllerProtocol: AnyObject {
    func reloadTableView()
}

final class StatisticsViewController: UIViewController, StatisticsViewControllerProtocol {

    let cellReuseIdentifier = "StatisticsViewController"

    private let presenter: StatisticsPresenterProtocol
    private let cart: CartControllerProtocol
    private let appMetricScreenName = "MainStatisticScreen"
    private let appMetric = AppMetrics()

    private lazy var statisticsFilterButton: UIButton = {
        let statisticsFilterButton = UIButton(type: .custom)
        statisticsFilterButton.setImage(UIImage(named: "sort")?.withTintColor(.blackDayNight), for: .normal)
        statisticsFilterButton.translatesAutoresizingMaskIntoConstraints = false
        statisticsFilterButton.addTarget(self, action: #selector(statisticsFilterTapped), for: .touchUpInside)
        return statisticsFilterButton
    }()

    private let statisticsTableView: UITableView = {
        let statisticsTableView = UITableView()
        statisticsTableView.separatorStyle = .none
        statisticsTableView.translatesAutoresizingMaskIntoConstraints = false
        return statisticsTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .whiteDayNight
        addSubviews()
        setupConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: statisticsFilterButton)
        setupTableView()

        presenter.view = self
        presenter.loadDataFromServer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appMetric.reportEvent(screen: appMetricScreenName, event: .open, item: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        appMetric.reportEvent(screen: appMetricScreenName, event: .close, item: nil)
    }

    init(presenter: StatisticsPresenterProtocol, cart: CartControllerProtocol) {
        self.presenter = presenter
        self.cart = cart
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func statisticsFilterTapped() {
        appMetric.reportEvent(screen: appMetricScreenName, event: .click, item: .statisticFilter)
        let alertController = presenter.sortButtonTapped()
        present(alertController, animated: true, completion: nil)
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.statisticsTableView.reloadData()
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statisticsFilterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            statisticsFilterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            statisticsFilterButton.heightAnchor.constraint(equalToConstant: 42),

            statisticsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            statisticsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            statisticsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func addSubviews() {
        view.addSubview(statisticsFilterButton)
        view.addSubview(statisticsTableView)
    }

    private func setupTableView() {
        statisticsTableView.backgroundColor = .whiteDayNight
        statisticsTableView.delegate = self
        statisticsTableView.dataSource = self
        statisticsTableView.register(StatisticsCell.self)
    }
}

// MARK: - UITableViewDelegate
extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        guard let cell = tableView.cellForRow(at: indexPath) as? StatisticsCell else { return }
        let cellImage = cell.avatarImage

        guard let user = presenter.user(at: indexPath.row) else { return }

        let model = UserCardService(user: user, userAvatar: cellImage)
        let presenter = UserCardPresenter(model: model)
        let userCardViewController = UserCardViewController(presenter: presenter, cart: cart)
        userCardViewController.modalPresentationStyle = .fullScreen

        self.present(userCardViewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.usersCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsCell = tableView.dequeueReusableCell()

        let selectedView = UIView()
        selectedView.backgroundColor = .whiteDayNight
        selectedView.layer.cornerRadius = 12
        cell.selectedBackgroundView = selectedView

        guard let user = presenter.user(at: indexPath.row) else { return UITableViewCell() }

        DispatchQueue.main.async {
            cell.updateCell(number: (indexPath.row + 1), avatar: UIImage(), name: user.name, rating: user.rating)
            self.presenter.loadProfileImage(imageView: cell.avatarImage, url: user.avatar)
        }

        return cell
    }
}
