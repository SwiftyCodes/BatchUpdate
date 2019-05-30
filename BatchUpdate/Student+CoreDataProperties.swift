//
//  Student+CoreDataProperties.swift
//  BatchUpdate
//
//  Created by chetu on 5/30/19.
//  Copyright © 2019 chetu. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var studentName: String?
    @NSManaged public var studentRollNo: Int64

}
