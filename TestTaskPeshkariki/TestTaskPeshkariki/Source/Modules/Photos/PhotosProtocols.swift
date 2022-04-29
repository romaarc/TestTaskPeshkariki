//
//  PhotosProtocols.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//  
//

import Foundation

protocol PhotosModuleInput {
	var moduleOutput: PhotosModuleOutput? { get }
}

protocol PhotosModuleOutput: AnyObject {}

protocol PhotosViewInput: ViewInput {
    func set(viewModels: [PhotoViewModel])
}

protocol PhotosViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplay(at index: Int)
}

protocol PhotosInteractorInput: InteractorInput {}

protocol PhotosInteractorOutput: InteractorOutput {
    func didLoad(with photos: [Photo], loadType: LoadingDataType, count: Int)
}

protocol PhotosRouterInput: AnyObject {}
