//
//  OnboardingViewController.swift
//  NFT Marketplace
//
//  Created by Margarita Pitinova on 20.09.2023.
//

import UIKit

final class OnboardingViewController: UIPageViewController {
    
    private let appConfiguration = AppConfiguration()
    private var pages: [UIViewController] = []
    private var currentPageIndex = 0
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        pageControl.preferredIndicatorImage = UIImage(named: "PaginationNoActive")
        if #available(iOS 16.0, *) {
            pageControl.preferredCurrentPageIndicatorImage = UIImage(named: "PaginationActive")
        } else {
        }
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что внутри?", for: .normal)
        button.backgroundColor = .blackDayNight
        button.layer.cornerRadius = 16
        button.setTitleColor(.whiteDayNight, for: .normal)
        button.titleLabel?.font = .bodyBold
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        let page1 = createOnboardingPage(imageName: "OnboardingImage1", labelText: "Исследуйте", descriptionText: "Присоединяйтесь и откройте новый мир\nуникальных NFT для коллекционеров")
        let page2 = createOnboardingPage(imageName: "OnboardingImage2", labelText: "Коллекционируйте", descriptionText: "Пополняйте свою коллекцию эксклюзивными\nкартинками, созданными нейросетью!")
        let page3 = createOnboardingPage(imageName: "OnboardingImage3", labelText: "Состязайтесь", descriptionText: "Смотрите статистику других и покажите всем,\nчто у вас самая ценная коллекция")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            button.isHidden = true
        }
        
        view.addSubview(pageControl)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func buttonTapped() {
        let tabBarController = TabBarController(appConfiguration: appConfiguration)
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        window.rootViewController = tabBarController
    }
    
    func createOnboardingPage(imageName: String, labelText: String, descriptionText: String) -> UIViewController {
        let onboardingVC = UIViewController()
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        onboardingVC.view.addSubview(imageView)
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .whiteDayNight
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        onboardingVC.view.addSubview(label)
        
        let description = UILabel()
        description.text = descriptionText
        description.numberOfLines = 2
        description.textColor = .whiteDayNight
        description.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        description.textAlignment = .left
        description.translatesAutoresizingMaskIntoConstraints = false
        onboardingVC.view.addSubview(description)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: onboardingVC.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: onboardingVC.view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: onboardingVC.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: onboardingVC.view.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: onboardingVC.view.topAnchor, constant: 230),
            label.leadingAnchor.constraint(equalTo: onboardingVC.view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: onboardingVC.view.trailingAnchor, constant: -16),
            
            description.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            description.leadingAnchor.constraint(equalTo: onboardingVC.view.leadingAnchor, constant: 16),
            description.trailingAnchor.constraint(equalTo: onboardingVC.view.trailingAnchor, constant: -16)
        ])
        
        return onboardingVC
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
                
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else {
            return nil
        }
                
        return pages[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
            
            currentPageIndex = currentIndex
            button.isHidden = currentIndex != 2
        }
    }
}
