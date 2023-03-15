//
//  CoreDataManager.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 10/7/21.
//

import CoreData
import Foundation

class CoreDataManager {
    
    private let modelName: String
    
    static let manager = CoreDataManager(name: "PracticingCoreData")
    
    init(name: String) {
        self.modelName = name
    }
    
    private(set) lazy var mainManagerObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        return context
    }()
    
    private(set) lazy var privateObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.storeCoordinator
        return context
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: self.modelName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
                  fatalError("Can't load data model")
              }
        return managedObjectModel
    }()
    
    private lazy var storeCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let storeUrl = docDirectory.appendingPathComponent(storeName)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        } catch {
            fatalError("Can't load persistent store")
        }
        
        return coordinator
    }()
    
    func saveChanges() {
        self.privateObjectContext.perform {
            do {
                if self.privateObjectContext.hasChanges {
                    try self.privateObjectContext.save()
                }
            } catch {
                let error = error as NSError
                print(error)
            }
        }
    }
}
