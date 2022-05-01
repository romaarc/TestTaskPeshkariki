//
//  URLFactory.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

enum URLFactory {
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func getPhotos(params: PhotoURLParameters) -> URLRequest {
        var urlComponents = baseURLComponents
        if !params.query.isEmpty {
            let paramsQueryItem = [
                URLQueryItem(name: "query", value: params.query),
                URLQueryItem(name: "per_page", value: "10"),
                URLQueryItem(name: "page", value: params.page ?? "")
            ]
            urlComponents.queryItems?.append(contentsOf: paramsQueryItem)
        } else {
            let paramsQueryItem = [
                URLQueryItem(name: "page", value: params.page ?? ""),
                URLQueryItem(name: "per_page", value: "10")
            ]
            urlComponents.queryItems?.append(contentsOf: paramsQueryItem)
        }
    
        var request = URLRequest(url: urlComponents.url!.appendingPathComponent(!params.query.isEmpty ? API.TypeOf.searchPhotos : API.TypeOf.photos))
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        for header in HTTPHeader.default {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return request
    }
    
    static func getPhoto(params: PhotoDetailURLParameters) -> URLRequest {
        let url = URL(string: API.main + API.TypeOf.photos + "/" + params.id)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        for header in HTTPHeader.default {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return request
    }
}

enum HTTPHeader: Hashable {
    case apiKey
    var key: String {
        switch self {
        case .apiKey: return API.authorization
        }
    }
    var value: String {
        switch self {
        case .apiKey: return API.key
        }
    }
    static var `default`: [HTTPHeader] {
        return [.apiKey]
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
