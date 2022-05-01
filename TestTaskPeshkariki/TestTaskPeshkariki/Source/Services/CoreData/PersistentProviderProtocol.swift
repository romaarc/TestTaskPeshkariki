//
//  PersistentProviderProtocol.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import Foundation

protocol PersistentProviderProtocol {
    func update(where models: [PhotoViewModel], to action: PersistentState, and completion: @escaping (Result<PersistentState, Error>) -> Void)
    func requestModels() -> [PCDModel]
    func requestModels(withId id: String) -> [PCDModel]
}
