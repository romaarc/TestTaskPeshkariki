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
}

struct URLParameters {
    var page: String?
}
