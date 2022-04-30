//
//  PCDModel+CoreDataProperties.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//
//

import Foundation
import CoreData


extension PCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PCDModel> {
        return NSFetchRequest<PCDModel>(entityName: "PCDModel")
    }

    @NSManaged public var id: String?
    @NSManaged public var url: String?
    @NSManaged public var autorName: String?
    @NSManaged public var currentDate: Date?
    @NSManaged public var isFavorite: Bool

}

extension PCDModel : Identifiable {

}
