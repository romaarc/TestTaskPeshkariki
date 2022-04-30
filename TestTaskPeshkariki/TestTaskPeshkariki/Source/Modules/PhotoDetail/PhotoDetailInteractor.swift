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
    func save(with viewModel: PhotoViewModel) {
        let workItem = DispatchWorkItem {
            self.persistentProvider.update(where: [viewModel], to: .add) { _ in }
        }
        DispatchQueue.global(qos: .background).async(execute: workItem)
    }
}
