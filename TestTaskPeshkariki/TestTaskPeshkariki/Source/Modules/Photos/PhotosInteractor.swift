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
    private var params: PhotoURLParameters
    private var photosDetail: [String: PhotoDetail] = [:]
    
    init(unsplashNetworkService: NetworkServiceProtocol) {
        self.unsplashNetworkService = unsplashNetworkService
        self.params = PhotoURLParameters(page: String(self.page))
    }
}

extension PhotosInteractor: PhotosInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        params = PhotoURLParameters(page: String(self.page))
        load()
    }
    
    func loadNext() {
        load()
    }
    
    func reload(withParams params: PhotoURLParameters) {
        page = GlobalConstants.initialPage
        self.params = params
        load()
    }
}

private extension PhotosInteractor {
    func load() {
        let maxPage = 2
        let maxCount = 20
        let queue = DispatchQueue.global(qos: .userInteractive)
        let group = DispatchGroup()
        
        unsplashNetworkService.fetchPhotos(with: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                for photo in response {
                    group.enter()
                    queue.async { [self] in
                        self.unsplashNetworkService.fetchPhoto(with: PhotoDetailURLParameters(id: photo.id)) { [weak self] result in
                            defer { group.leave() }
                            guard let self = self else { return }
                            switch result {
                            case.success(let response):
                                self.photosDetail[response.id] = response
                            case .failure(let error):
                                self.output?.didError(with: error)
                            }
                        }
                    }
                }
                
                group.notify(queue: queue) { [weak self] in
                    guard let self = self else { return }
                    self.output?.didLoad(with: response, and: self.photosDetail, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount)
                    if self.page == maxPage {
                        self.page = maxPage
                    } else {
                        self.page += 1
                    }
                    self.params.page = String(self.page)
                }
                
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
}
