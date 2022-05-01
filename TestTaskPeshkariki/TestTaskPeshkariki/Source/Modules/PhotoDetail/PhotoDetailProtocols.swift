//
//  PhotoDetailProtocols.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import Foundation

protocol PhotoDetailModuleInput {
	var moduleOutput: PhotoDetailModuleOutput? { get }
}

protocol PhotoDetailModuleOutput: AnyObject {
    func back()
}

protocol PhotoDetailViewInput: AnyObject {
    func setSaveButton(isSaved: Bool)
}

protocol PhotoDetailViewOutput: AnyObject {
    func viewDidLoad(withId id: String)
    func onSaveButtonTap(with viewModel: PhotoViewModel)
    func remove(with viewModel: PhotoViewModel)
    func back()
}

protocol PhotoDetailInteractorInput: AnyObject {
    func update(with viewModel: PhotoViewModel, and state: PersistentState)
    func get(withId id: String)
}

protocol PhotoDetailInteractorOutput: AnyObject {
    func didLoadFromCD(isSaved: Bool)
}

protocol PhotoDetailRouterInput: AnyObject {}
