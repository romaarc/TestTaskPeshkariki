//
//  API.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

enum API {
    static let main = "https://api.unsplash.com"
    static let key = "Client-ID 0zPmX8PqONcsMaC3Xsqa_hNyKtTaZcAc_aCl7-9o1SY"
    static let authorization = "Authorization"
    
    enum TypeOf {
        static let photos = "/photos"
        static let searchPhotos = "/search/photos"
    }
}

//https://api.unsplash.com/search/photos/?client_id=0zPmX8PqONcsMaC3Xsqa_hNyKtTaZcAc_aCl7-9o1SY&query=sunset&per_page=10&page=1
