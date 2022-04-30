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

protocol PhotoFavoriteModuleOutput: class {
}

protocol PhotoFavoriteViewInput: class {
}

protocol PhotoFavoriteViewOutput: class {
}

protocol PhotoFavoriteInteractorInput: class {
}

protocol PhotoFavoriteInteractorOutput: class {
}

protocol PhotoFavoriteRouterInput: class {
}
