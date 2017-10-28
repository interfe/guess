//
//  Lesson+CoreDataProperties.swift
//  guess
//
//  Created by O_Kenta on 2017/10/28.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var absence: Int64
    @NSManaged public var attend: Int64
    @NSManaged public var cancel: Int64
    @NSManaged public var colum: Int64
    @NSManaged public var late: Int64
    @NSManaged public var room: String?
    @NSManaged public var row: Int64
    @NSManaged public var title: String?

}
