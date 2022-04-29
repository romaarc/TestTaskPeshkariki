//
//  NetworkService+Photos.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    func fetchPhotos(with params: URLParameters, and completion: @escaping (Result<[Photo], Error>) -> Void) {
        let request = URLFactory.getPhotos(params: params)
        self.baseRequest(request: request, completion: completion)
    }
}
