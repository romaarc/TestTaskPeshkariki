//
//  PhotoFavoriteProtocols.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import Foundation

protocol PhotoFavoriteModuleInput {
	var moduleOutput: PhotoFavoriteModuleOutput? { get }
}

protocol PhotoFavoriteModuleOutput: AnyObject {}

protocol PhotoFavoriteViewInput: ViewInput {
    func set(viewModels: [PCDModel])
}

protocol PhotoFavoriteViewOutput: AnyObject {
    func viewDidLoad()
    func onCellTap(with viewModel: PhotoViewModel)
}

protocol PhotoFavoriteInteractorInput: AnyObject {
    func request()
}

protocol PhotoFavoriteInteractorOutput: AnyObject {
    func didLoad(with photos: [PCDModel])
}

protocol PhotoFavoriteRouterInput: AnyObject {
    func showDetail(with viewModel: PhotoViewModel)
}
