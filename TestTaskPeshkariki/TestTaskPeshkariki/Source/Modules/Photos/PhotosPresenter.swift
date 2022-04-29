//
//  PhotosPresenter.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//  
//

import Foundation

final class PhotosPresenter {
	weak var view: PhotosViewInput?
    weak var moduleOutput: PhotosModuleOutput?
    
	private let router: PhotosRouterInput
	private let interactor: PhotosInteractorInput
    
    private var isNextPageLoading = false
    private var isReloading = false
    private var photos: [Photo] = []
    private var count: Int = 0
    
    init(router: PhotosRouterInput, interactor: PhotosInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PhotosPresenter: PhotosModuleInput {
}

extension PhotosPresenter: PhotosViewOutput {
    func willDisplay(at index: Int) {
        guard !isReloading, !isNextPageLoading, index == (photos.count - 1), index >= 19, photos.count != self.count else {
            return
        }
        view?.startActivityIndicator()
        interactor.loadNext()
    }
    
    func viewDidLoad() {
        view?.startActivityIndicator()
        isReloading = true
        interactor.reload()
    }
    
}

extension PhotosPresenter: PhotosInteractorOutput {
    func didLoad(with photos: [Photo], loadType: LoadingDataType, count: Int) {
        switch loadType {
        case .nextPage:
            isNextPageLoading = false
            self.photos.append(contentsOf: photos)
        case .reload:
            isReloading = false
            self.photos = photos
        }
        self.count += count
        let viewModels: [PhotoViewModel] = PhotosPresenter.makeViewModels(self.photos)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
}

extension PhotosPresenter {
    static func makeViewModels(_ photos: [Photo]) -> [PhotoViewModel] {
        return photos.map { photo in
            PhotoViewModel(id: photo.id,
                           user: photo.user,
                           urls: photo.urls)
        }
    }
}
