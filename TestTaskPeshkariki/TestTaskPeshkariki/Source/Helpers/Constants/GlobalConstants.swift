//
//  GlobalConstants.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 29.04.2022.
//

import Foundation
import UIKit

struct GlobalConstants {
    static let initialPage = 1
}

struct PhotoDetailConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 79
        static let tableDescriptionCellHeight: CGFloat = 105
        static let numberOfSections = 1
        static let locationCellIndex: Int = 3
        static let cellCount: Int = 4
    }
    
    struct Strings {
        static let headerInfo = "Информация"
        static let emptyMessage = "Не найдено информации"
    }
}

struct PhotosConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 79
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 9
        static let spacingLeft: CGFloat = 9
        static let spacingTop: CGFloat = 9
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 23
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
        
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Design {
        static var shadowColor = UIColor.black
    }
    
    struct Strings {
        static let emptyMessageDidError = "Не найдено фотографий или подключитесь к сети, чтобы загрузить данные или закончился лимит на 50 запросов к API"
        static let emptyMessage = "Не найдено фотографий"
        static let searchBarPlaceholder = "Найти фотографии"
        static let UISearchBarTitle = "Отменить"
    }
}
