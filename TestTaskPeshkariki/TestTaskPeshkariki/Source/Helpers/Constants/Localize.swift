//
//  Localize.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import UIKit

enum Localize {
    static let photos = "Unsplash"
    static let locations = "Локации"
    
    enum Images {
        static let charactersIcon = UIImage(systemName: "person.3")!
        static let locationIcon = UIImage(systemName: "globe")!
        static let episodesIcon = UIImage(systemName: "tv")!
        static let characterFilterSymbol = UIImage(systemName: "line.horizontal.3.decrease.circle")
        static let statusSymbol = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .regular, scale: .default))
    }
}
