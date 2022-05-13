//
//  MovieIt+CoreDataProperties.swift
//  
//
//  Created by 효우 on 2022/05/12.
//
//

import Foundation
import CoreData


extension MovieIt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieIt> {
        return NSFetchRequest<MovieIt>(entityName: "MovieIt")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?

}
