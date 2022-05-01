//
//  PhotoFavoriteInteractor.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import Foundation

final class PhotoFavoriteInteractor {
	weak var output: PhotoFavoriteInteractorOutput?
    private var persistentProvider: PersistentProviderProtocol
    
    init(persistentProvider: PersistentProviderProtocol) {
        self.persistentProvider = persistentProvider
    }
}

extension PhotoFavoriteInteractor: PhotoFavoriteInteractorInput {
    func request() {
       // persistentProvider.update(where: [], to: .remove) { _ in }
        let models = persistentProvider.requestModels()
        output?.didLoad(with: models)
    }
    
}
