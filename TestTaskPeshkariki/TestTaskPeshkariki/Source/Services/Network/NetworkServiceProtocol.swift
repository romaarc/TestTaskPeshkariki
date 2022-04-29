//
//  NetworkServiceProtocol.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchPhotos(with params: URLParameters, and completion: @escaping (Result<[Photo], Error>) -> Void)
}