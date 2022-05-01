//
//  PhotoFavoriteRouter.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//  
//

import UIKit

final class PhotoFavoriteRouter: BaseRouter {}

extension PhotoFavoriteRouter: PhotoFavoriteRouterInput {
    func showDetail(with viewModel: PhotoViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = PhotoDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = PhotoDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension PhotoFavoriteRouter: PhotoDetailModuleOutput {
    func back() {
        guard let viewController = viewController else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popToViewController(viewController, animated: true)
        }
    }
}
