//
//  PhotoDetailInteractor.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import Foundation

final class PhotoDetailInteractor {
	weak var output: PhotoDetailInteractorOutput?
    private var persistentProvider: PersistentProviderProtocol
    
    init(persistentProvider: PersistentProviderProtocol) {
        self.persistentProvider = persistentProvider
    }
}

extension PhotoDetailInteractor: PhotoDetailInteractorInput {
    func get(withId id: String) {
        let models = persistentProvider.requestModels(withId: id)
        guard models.count > 0 else { return }
        output?.didLoadFromCD(isSaved: models[0].isFavorite)
    }
    
    func update(with viewModel: PhotoViewModel, and state: PersistentState) {
        let workItem = DispatchWorkItem { [weak self] in
            self?.persistentProvider.update(where: [viewModel], to: state) { _ in }
        }
        DispatchQueue.global(qos: .background).async(execute: workItem)
    }
}
