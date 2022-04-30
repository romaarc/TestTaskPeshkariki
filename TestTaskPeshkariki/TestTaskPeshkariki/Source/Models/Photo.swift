//
//  Photo.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let user: User
    let urls: Urls
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id, user, urls
        case createdAt = "created_at"
    }
}

struct PhotoURLParameters {
    var page: String?
    var query: String
}

extension PhotoURLParameters {
    init(page: String) {
        self.page = page
        self.query = ""
    }
}
