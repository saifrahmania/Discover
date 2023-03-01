//
//  Bookmark+CoreDataProperties.swift
//  
//
//  Created by BJIT on 17/1/23.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var author: String?
    @NSManaged public var category: String?
    @NSManaged public var content: String?
    @NSManaged public var descript: String?
    @NSManaged public var name: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var source: String?
    
    static var bookmarkArray = [Bookmark]()

}
