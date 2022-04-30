//
//  PhotoDetailContainer.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import UIKit

final class PhotoDetailContainer {
    let input: PhotoDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: PhotoDetailRouterInput!

	static func assemble(with context: PhotoDetailContext, withModel viewModel: PhotoViewModel) -> PhotoDetailContainer {
        let router = PhotoDetailRouter()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter(router: router, interactor: interactor)
        let viewController = PhotoDetailViewController(output: presenter, viewModel: viewModel)

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

        return PhotoDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: PhotoDetailModuleInput, router: PhotoDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct PhotoDetailContext {
    let moduleDependencies: ModuleDependencies
	weak var moduleOutput: PhotoDetailModuleOutput?
}
