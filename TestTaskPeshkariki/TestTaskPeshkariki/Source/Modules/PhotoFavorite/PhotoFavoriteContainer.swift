//
//  PhotoFavoriteContainer.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import UIKit

final class PhotoFavoriteContainer {
    let input: PhotoFavoriteModuleInput
	let viewController: UIViewController
	private(set) weak var router: PhotoFavoriteRouterInput!

	static func assemble(with context: PhotoFavoriteContext) -> PhotoFavoriteContainer {
        let router = PhotoFavoriteRouter()
        let interactor = PhotoFavoriteInteractor(persistentProvider: context.moduleDependencies.persistentProvider)
        let presenter = PhotoFavoritePresenter(router: router, interactor: interactor)
		let viewController = PhotoFavoriteViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        router.viewControllerProvider = { [weak viewController] in
            viewController
        }
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        
        router.moduleDependencies = context.moduleDependencies

        return PhotoFavoriteContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: PhotoFavoriteModuleInput, router: PhotoFavoriteRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct PhotoFavoriteContext {
    let moduleDependencies: ModuleDependencies
	weak var moduleOutput: PhotoFavoriteModuleOutput?
}
