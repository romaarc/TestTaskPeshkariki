//
//  AppCoordinator.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    private let appDependency: AppDependency
    
    init(window: UIWindow, appDependency: AppDependency) {
        self.window = window
        self.appDependency = appDependency
        navigationControllers = AppCoordinator.makeNavigationControllers()
    }
    
    func start() {
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        setupPhotos()
        //setupLocation()
        //setupEpisode()
        
        let navigationControllers = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        setupAppearanceTabBar(with: tabBarController)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        var result: [NavigationControllersType: UINavigationController] = [:]
        NavigationControllersType.allCases.forEach { navigationControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem: UITabBarItem = UITabBarItem(title: navigationControllerKey.title,
                                                        image: navigationControllerKey.image,
                                                        tag: navigationControllerKey.rawValue)
            navigationController.tabBarItem = tabBarItem
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.sizeToFit()
            result[navigationControllerKey] = navigationController
        }
        return result
    }
    
    func setupPhotos() {
        guard let navController = self.navigationControllers[.photos] else {
            fatalError("something wrong with appCoordinator")
        }
        let context = PhotosContext(moduleDependencies: appDependency, moduleOutput: nil)
        let container = PhotosContainer.assemble(with: context)
        let photosVC = container.viewController
        photosVC.navigationItem.title = Localize.photos
        navController.setViewControllers([photosVC], animated: false)
        setupAppearanceNavigationBar(with: navController)
    }
    
//    func setupLocation() {
//        guard let navController = self.navigationControllers[.locations] else {
//            fatalError("something wrong with appCoordinator")
//        }
//        let context = LocationContext(moduleDependencies: appDependency, moduleOutput: nil)
//        let container = LocationContainer.assemble(with: context)
//        let locationVC = container.viewController
//        locationVC.navigationItem.title = Localize.locations
//        navController.setViewControllers([locationVC], animated: false)
//        setupAppearanceNavigationBar(with: navController)
//    }
    
    func setupAppearanceTabBar(with controller: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.backgroundColor = Colors.lightGray
        
        if #available(iOS 15.0, *) {
            controller.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        controller.tabBar.standardAppearance = tabBarAppearance
        controller.tabBar.unselectedItemTintColor = Colors.grayTabBar
        controller.selectedIndex = 0
        
        UITabBar.appearance().tintColor = Colors.purple
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        tabBarItemAppearance.selected.titleTextAttributes = [.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: controller.tabBar.frame.width, y: 0))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = Colors.lightWhite.cgColor
        shapeLayer.lineWidth = 0.4

        controller.tabBar.layer.addSublayer(shapeLayer)
    }
    
    func setupAppearanceNavigationBar(with controller: UINavigationController) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = Colors.lightGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                       .font : Font.sber(ofSize: Font.Size.twenty, weight: .bold)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                            .font : Font.sber(ofSize: Font.Size.thirdyFour, weight: .bold),
                                                            .paragraphStyle: paragraphStyle,
                                                            .kern: 0.41]
        UINavigationBar.appearance().tintColor = Colors.purple
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationBar.shadowImage = UIImage()
    }
}

fileprivate enum NavigationControllersType: Int, CaseIterable {
    case photos, locations
    var title: String {
        switch self {
        case .photos:
            return Localize.photos
        case .locations:
            return Localize.locations
        }
    }
    
    var image: UIImage {
        switch self {
        case .photos:
            return Localize.Images.charactersIcon
        case .locations:
            return Localize.Images.locationIcon
        }
    }
}
