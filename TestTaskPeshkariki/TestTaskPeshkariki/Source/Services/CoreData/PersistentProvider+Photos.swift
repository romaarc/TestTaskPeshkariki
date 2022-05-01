//
//  PersistentProvider+Photos.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import Foundation
import CoreData

extension PersistentProvider: PersistentProviderProtocol {
    func update(where models: [PhotoViewModel], to action: PersistentState, and completion: @escaping (Result<PersistentState, Error>) -> Void) {
        switch action  {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let photos = try? self.fetchRequest(for: $0).execute().first {
                        photos.update(with: $0)
                        ///adding
                    } else {
                        let cdModel = PCDModel(context: backgroundViewContext)
                        cdModel.configNew(with: $0)
                    }
                }
                saveContext()
            }
        case .update:
            break
        case .remove:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let photos = try? self.fetchRequest(for: $0).execute().first {
                        photos.update(with: $0, isFav: false)
                    }
                }
                saveContext()
            }
        }
    }

    func requestModels() -> [PCDModel] {
        let request = PCDModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [PCDModel]() }
        return table
    }

    func requestModels(withId id: String) -> [PCDModel] {
        let request = PCDModel.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "id == %@", id)
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [PCDModel]() }
        return table
    }
}

//MARK: - FetchRequest with id CD Model Photo and extension CDModel
private extension PersistentProvider {
    func fetchRequest(for photo: PhotoViewModel) -> NSFetchRequest<PCDModel> {
        let request = PCDModel.fetchRequest()
        request.predicate = .init(format: "id == %@", photo.id)
        return request
    }
}

fileprivate extension PCDModel {
    func update(with photo: PhotoViewModel, isFav: Bool = true) {
        url = photo.urls.regular
        autorName = photo.user.name
        isFavorite = isFav
        currentDate = Date()
        city = photo.location.city ?? ""
        country = photo.location.country ?? ""
        downloads = Int64(photo.downloads)
        createdAt = photo.createdAt
    }

    func configNew(with photo: PhotoViewModel) {
        id = photo.id
        update(with: photo)
    }
}
