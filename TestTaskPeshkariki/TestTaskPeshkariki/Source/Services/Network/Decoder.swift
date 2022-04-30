//
//  Decoder.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation

protocol CustomDecoder {
    var decoder: JSONDecoder { get }
}

final class JSONDecoderCustom: CustomDecoder {
    private(set) var decoder = JSONDecoder()
    
    init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
    }
}
