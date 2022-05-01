//
//  PhotoDetailPresenter.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import Foundation

final class PhotoDetailPresenter {
	weak var view: PhotoDetailViewInput?
    weak var moduleOutput: PhotoDetailModuleOutput?
    
	private let router: PhotoDetailRouterInput
	private let interactor: PhotoDetailInteractorInput
    
    init(router: PhotoDetailRouterInput, interactor: PhotoDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PhotoDetailPresenter: PhotoDetailModuleInput {}

extension PhotoDetailPresenter: PhotoDetailViewOutput {
    func remove(with viewModel: PhotoViewModel) {
        interactor.update(with: viewModel, and: .remove)
    }
    
    func viewDidLoad(withId id: String) {
        interactor.get(withId: id)
    }
    
    func onSaveButtonTap(with viewModel: PhotoViewModel) {
        interactor.update(with: viewModel, and: .add)
    }
    
    func back() {
        moduleOutput?.back()
    }
}

extension PhotoDetailPresenter: PhotoDetailInteractorOutput {
    func didLoadFromCD(isSaved: Bool) {
        view?.setSaveButton(isSaved: isSaved)
    }
}
