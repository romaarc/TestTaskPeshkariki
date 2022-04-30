//
//  NetworkService+Photos.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    func fetchPhotos(with params: PhotoURLParameters, and completion: @escaping (Result<[Photo], Error>) -> Void) {
        let request = URLFactory.getPhotos(params: params)
        self.baseRequest(request: request, completion: completion)
    }
    
    func fetchPhoto(with params: PhotoDetailURLParameters, and completion: @escaping (Result<PhotoDetail, Error>) -> Void) {
        let request = URLFactory.getPhoto(params: params)
        self.baseRequest(request: request, completion: completion)
    }
    
    func fetchSearchPhotos(with params: PhotoURLParameters, and completion: @escaping (Result<Response<Photo>, Error>) -> Void) {
        let request = URLFactory.getPhotos(params: params)
        self.baseRequest(request: request, completion: completion)
    }
}
