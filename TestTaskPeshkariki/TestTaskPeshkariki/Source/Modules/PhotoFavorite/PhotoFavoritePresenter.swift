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
    func viewDidLoad() {
        view?.startActivityIndicator()
        interactor.request()
    }
    
    func onCellTap(with viewModel: PhotoViewModel) {
        router.showDetail(with: viewModel)
    }
}

extension PhotoFavoritePresenter: PhotoFavoriteInteractorOutput {
    func didLoad(with photos: [PCDModel]) {
        view?.set(viewModels: photos)
        view?.stopActivityIndicator()
    }
    
}
