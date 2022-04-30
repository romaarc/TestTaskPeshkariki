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

protocol PhotoDetailModuleOutput: AnyObject {}

protocol PhotoDetailViewInput: AnyObject {}

protocol PhotoDetailViewOutput: AnyObject {
    func onSaveButtonTap(with viewModel: PhotoViewModel)
}

protocol PhotoDetailInteractorInput: AnyObject {
    func save(with viewModel: PhotoViewModel)
}

protocol PhotoDetailInteractorOutput: AnyObject {}

protocol PhotoDetailRouterInput: AnyObject {}
