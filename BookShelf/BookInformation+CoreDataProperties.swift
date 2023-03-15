//
//  BookInformation+CoreDataProperties.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 10/8/21.
//
//

import CoreData
import Foundation

extension BookInformation {
    
    /// fetching a request
    /// - Returns: NSFetchRequest
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<BookInformation> {
        return NSFetchRequest<BookInformation>(entityName: "BookInformation")
    }
    
    /// Book title
    @NSManaged public var bookTitle: String?
    /// book authors
    @NSManaged public var bookAuthors: String?
    /// book description
    @NSManaged public var bookDescription: String?
    /// book id
    @NSManaged public var bookId: String?
}

extension BookInformation: Identifiable {
}
