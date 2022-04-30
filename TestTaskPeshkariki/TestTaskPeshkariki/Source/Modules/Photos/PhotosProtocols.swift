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
    func onCellTap(with viewModel: PhotoViewModel)
    func searchBarTextDidEndEditing(with searchText: String)
    func searchBarCancelButtonClicked()
}

protocol PhotosInteractorInput: InteractorInput {
    func reload(withParams params: PhotoURLParameters)
}

protocol PhotosInteractorOutput: InteractorOutput {
    func didLoad(with photos: [Photo], and detail: [String: PhotoDetail], loadType: LoadingDataType, count: Int)
}

protocol PhotosRouterInput: AnyObject {
    func showDetail(with viewModel: PhotoViewModel)
}
