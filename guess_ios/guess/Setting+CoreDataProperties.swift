//
//  Setting+CoreDataProperties.swift
//  guess
//
//  Created by O_Kenta on 2017/10/28.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//
//

import Foundation
import CoreData


extension Setting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Setting> {
        return NSFetchRequest<Setting>(entityName: "Setting")
    }

    @NSManaged public var no_absence: Int64
    @NSManaged public var no_class: Int64
    @NSManaged public var no_lesson: Int64
    @NSManaged public var time: Int64

}
