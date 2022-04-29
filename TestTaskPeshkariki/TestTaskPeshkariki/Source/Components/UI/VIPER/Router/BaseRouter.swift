//
//  BaseRouter.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import UIKit

class BaseRouter {
    var moduleDependencies: ModuleDependencies?
    
    var navigationControllerProvider: (() -> UINavigationController?)?
    var navigationController: UINavigationController? {
        self.navigationControllerProvider?()
    }
    
    var viewControllerProvider: (() -> UIViewController?)?
    var viewController: UIViewController? {
        self.viewControllerProvider?()
    }
}
