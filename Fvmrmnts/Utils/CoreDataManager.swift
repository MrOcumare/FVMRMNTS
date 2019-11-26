//
//  CoreDataManager.swift
//  Fvmrmnts
//
//  Created by y.bogdanov on 26.11.2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared = CoreDataManager()
        
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fvmrmnts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveObjects() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try! context.save()
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgrounContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func objects(with request: NSFetchRequest<NSFetchRequestResult>, then completion: @escaping (Result<[NSFetchRequestResult],Error>) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            let result = try! context.fetch(request) as! [NSFetchRequestResult]
            completion(.success(result))
        }
    }
    
    func delete(_ object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.perform {
            context.delete(object)
            try! context.save()
        }
    }
    
    func getObjectSync(with request: NSFetchRequest<NSFetchRequestResult>) -> [NSFetchRequestResult]{
        let context = persistentContainer.viewContext
        var result = [NSFetchRequestResult]()
        context.performAndWait {
            result = try! context.fetch(request) as! [NSFetchRequestResult]
        }
        return result
    }
    
}
