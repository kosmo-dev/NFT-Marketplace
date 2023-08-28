//
//  StatisticsViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 27.08.2023.
//

import UIKit

final class StatisticsViewController: UIViewController {

    let cellReuseIdentifier = "StatisticsViewController"

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
    }
    
    @objc private func statisticsFilterTapped() {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
               
               let sortByNameAction = UIAlertAction(title: "По имени", style: .default) { _ in
                   // Действие по выбору сортировки по имени
               }
               alertController.addAction(sortByNameAction)
               
               let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { _ in
                   // Действие по выбору сортировки по рейтингу
               }
               alertController.addAction(sortByRatingAction)
               
               let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
               alertController.addAction(closeAction)

               present(alertController, animated: true, completion: nil)
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
        // переход на новый контроллер с профилем пользователя по нажатию на ячейку
    }
}

// MARK: - UITableViewDataSource
extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12 // исправить на count кол-во пользователей
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatisticsCell = tableView.dequeueReusableCell()
        
        cell.layer.cornerRadius = 12
        cell.updateCell(number: (indexPath.row + 1), avatar: UIImage(named: "UserPhoto") ?? UIImage(), name: "Alex", rating: 72)
        
        return cell
    }
    
    
}
