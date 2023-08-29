//
//  StatisticsViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 27.08.2023.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    func reloadTableView()
}

final class StatisticsViewController: UIViewController, ViewControllerProtocol {
    
    let cellReuseIdentifier = "StatisticsViewController"
    
    private var presenter: UserDataDelegate
    
    private lazy var statisticsFilterButton: UIButton = {
        let statisticsFilterButton = UIButton(type: .custom)
        statisticsFilterButton.setImage(UIImage(named: "StatisticsFilter")?.withTintColor(.blackDayNight), for: .normal)
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
        
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: statisticsFilterButton)
        setupTableView()
        
        presenter.viewController = self
        presenter.didLoadDataFromServer()
    }
    
    init(presenter: UserDataDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func statisticsFilterTapped() {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        
        let sortByNameAction = UIAlertAction(title: "По имени", style: .default) { _ in
            self.presenter.sortByName()
            self.reloadTableView()
        }
        alertController.addAction(sortByNameAction)
        
        let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { _ in
            self.presenter.sortByRating()
            self.reloadTableView()
        }
        alertController.addAction(sortByRatingAction)
        
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        
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
        statisticsTableView.backgroundColor = .white
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
        statisticsTableView.deselectRow(at: indexPath, animated: true)
        //TODO: переход на новый контроллер с профилем пользователя по нажатию на ячейку
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsCell = tableView.dequeueReusableCell()
        
        guard let user = presenter.user(at: indexPath.row) else { return UITableViewCell() }
        
        presenter.didLoadImageForUser(at: indexPath.row) { image in
                    DispatchQueue.main.async {
                        if let image = image {
                            cell.updateCell(number: (indexPath.row + 1), avatar: image, name: user.name, rating: user.rating)
                        }
                    }
                }
        
        return cell
    }
}
