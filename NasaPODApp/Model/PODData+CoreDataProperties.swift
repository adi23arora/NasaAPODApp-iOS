//
//  PODData+CoreDataProperties.swift
// 
//
//  Created by Aditya Arora on 16/05/22.
//
//

import Foundation
import CoreData


extension PODData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PODData> {
        return NSFetchRequest<PODData>(entityName: "PODData")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: Data?
    @NSManaged public var date: String?
    @NSManaged public var explanation: String?

}
