//
//  ScanedWriting+CoreDataProperties.swift
//  
//
//  Created by juntaek.oh on 2023/11/04.
//
//

import Foundation
import CoreData


extension ScanedWriting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScanedWriting> {
        return NSFetchRequest<ScanedWriting>(entityName: "ScanedWriting")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var text: String?

}
