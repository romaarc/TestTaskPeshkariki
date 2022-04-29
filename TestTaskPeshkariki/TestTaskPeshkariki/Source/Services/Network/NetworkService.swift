//
//  NetworkService.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

enum NetworkErrors: Error {
    case wrongURL
    case dataIsEmpty
    case decodeIsFail
}

final class NetworkService {
    
    func baseRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let _ = request.url else {
            completion(.failure(NetworkErrors.wrongURL))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(request.url!)
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkErrors.dataIsEmpty))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedModel = try decoder.decode(T.self, from: data)
                completion(.success(decodedModel))
            } catch {
                completion(.failure(NetworkErrors.decodeIsFail))
            }
            
        }.resume()
    }
}
