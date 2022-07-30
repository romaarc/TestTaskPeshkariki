//
//  PCDModel+CoreDataProperties.swift
//  TestTaskPeshkariki
//
//  Created by Roman Gorshkov on 30.04.2022.
//
//

import CoreData

extension PCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PCDModel> {
        return NSFetchRequest<PCDModel>(entityName: PersistentConstants.cdModel)
    }

    @NSManaged public var id: String?
    @NSManaged public var url: String?
    @NSManaged public var autorName: String?
    @NSManaged public var currentDate: Date?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var downloads: Int64

}

extension PCDModel : Identifiable {}
