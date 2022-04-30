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
        let interactor = PhotoFavoriteInteractor()
        let presenter = PhotoFavoritePresenter(router: router, interactor: interactor)
		let viewController = PhotoFavoriteViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return PhotoFavoriteContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: PhotoFavoriteModuleInput, router: PhotoFavoriteRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct PhotoFavoriteContext {
	weak var moduleOutput: PhotoFavoriteModuleOutput?
}
