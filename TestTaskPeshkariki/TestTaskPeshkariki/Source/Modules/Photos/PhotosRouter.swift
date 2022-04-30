//
//  PhotosRouter.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//  
//

import UIKit

final class PhotosRouter: BaseRouter {}

extension PhotosRouter: PhotosRouterInput {
    func showDetail(with viewModel: PhotoViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = PhotoDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = PhotoDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
    
}

extension PhotosRouter: PhotoDetailModuleOutput {}
