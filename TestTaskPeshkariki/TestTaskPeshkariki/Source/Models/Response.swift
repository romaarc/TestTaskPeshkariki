//
//  Response.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let total: Int
    let totalPages: Int
    let results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case total, results
        case totalPages = "total_pages"
    }
}
