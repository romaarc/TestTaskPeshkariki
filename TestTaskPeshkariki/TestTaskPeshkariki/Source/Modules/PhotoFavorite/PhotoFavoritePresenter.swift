//
//  PhotoFavoritePresenter.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import Foundation

final class PhotoFavoritePresenter {
	weak var view: PhotoFavoriteViewInput?
    weak var moduleOutput: PhotoFavoriteModuleOutput?
    
	private let router: PhotoFavoriteRouterInput
	private let interactor: PhotoFavoriteInteractorInput
    
    init(router: PhotoFavoriteRouterInput, interactor: PhotoFavoriteInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PhotoFavoritePresenter: PhotoFavoriteModuleInput {
}

extension PhotoFavoritePresenter: PhotoFavoriteViewOutput {
}

extension PhotoFavoritePresenter: PhotoFavoriteInteractorOutput {
}
