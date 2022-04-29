//
//  PhotosInteractor.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//  
//

import Foundation

final class PhotosInteractor {
	weak var output: PhotosInteractorOutput?
    private let unsplashNetworkService: NetworkServiceProtocol
    //private var persistentProvider: PersistentProviderProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: URLParameters
    
    init(unsplashNetworkService: NetworkServiceProtocol) {
        self.unsplashNetworkService = unsplashNetworkService
        self.params = URLParameters(page: String(self.page))
    }
}

extension PhotosInteractor: PhotosInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        params = URLParameters(page: String(self.page))
        load()
    }
    
    func loadNext() {
        load()
    }
    
}

private extension PhotosInteractor {
    func load() {
        unsplashNetworkService.fetchPhotos(with: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let maxPage = 5
                let maxCount = 100
                self.output?.didLoad(with: response, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount)
                if self.page == maxPage {
                    self.page = maxPage
                } else {
                    self.page += 1
                }
                self.params.page = String(self.page)
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
}
