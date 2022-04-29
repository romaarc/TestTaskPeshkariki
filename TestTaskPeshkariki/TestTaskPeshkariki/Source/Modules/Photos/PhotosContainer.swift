//
//  PhotosContainer.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//  
//

import UIKit

final class PhotosContainer {
    let input: PhotosModuleInput
	let viewController: UIViewController
	private(set) weak var router: PhotosRouterInput!

	static func assemble(with context: PhotosContext) -> PhotosContainer {
        let router = PhotosRouter()
        let interactor = PhotosInteractor(unsplashNetworkService: context.moduleDependencies.UnsplashNetworkService)
        let presenter = PhotosPresenter(router: router, interactor: interactor)
		let viewController = PhotosViewController(output: presenter)

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

        return PhotosContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: PhotosModuleInput, router: PhotosRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct PhotosContext {
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: PhotosModuleOutput?
}
