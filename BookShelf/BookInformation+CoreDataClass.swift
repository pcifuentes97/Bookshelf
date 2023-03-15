//
//  BookInformation+CoreDataClass.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 10/8/21.
//
//

import CoreData
import Foundation

@objc(BookInformation)
public class BookInformation: NSManagedObject {

    static func insert(obj: BookInformation) {

        if read(bookId: obj.bookId).isEmpty {
            let context = CoreDataManager.manager.privateObjectContext
            guard let entity = NSEntityDescription.entity(forEntityName: "BookInformation", in: context) else { return }
            guard let book = NSManagedObject(entity: entity, insertInto: context) as? BookInformation else { return }
            book.bookTitle = obj.bookTitle
            book.bookAuthors = obj.bookAuthors
            book.bookDescription = obj.bookDescription
        }
    }
    
    static func delete(bookId: String) {

        let context = CoreDataManager.manager.privateObjectContext
        let request = BookInformation.fetchRequest() as NSFetchRequest<BookInformation>
        request.predicate = NSPredicate(format: "bookId = \(bookId)")
        
        do {
            let books = try context.fetch(request)
            books.forEach { context.delete($0) }
        } catch {
            print(error)
        }
    }

    static func read(bookId: String? = nil/*, sorting: [NSSortDescriptor]?*/) -> [BookInformation] {

        let context = CoreDataManager.manager.privateObjectContext
        let request = BookInformation.fetchRequest() as NSFetchRequest<BookInformation>
        if let bookId = bookId {
            request.predicate = NSPredicate(format: "bookId = \(bookId)")
        }
//        if let sortOption = sorting {
//            request.sortDescriptors = sortOption
//        }
        do {
            let books = try context.fetch(request)
            return books
        } catch {
            print(error)
        }
        return []
    }
    
    static func update(obj: BookInformation) {

        let context = CoreDataManager.manager.privateObjectContext
        let request = BookInformation.fetchRequest() as NSFetchRequest<BookInformation>
        request.predicate = NSPredicate(format: "bookId = \(obj.bookId ?? "")")
        do {
            let books = try context.fetch(request).first
            books?.bookDescription = obj.bookDescription
        } catch {
            print(error)
        }
    }
}
