//
//  PhotoDetail.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//

import Foundation

struct PhotoDetail: Decodable {
    let id: String
    let downloads: Int
    let location: Location
}

struct PhotoDetailURLParameters {
    var id: String
}
