//
//  CoreDataManager.swift
//  Manager
//
//  Created by juntaek.oh on 2023/11/04.
//  Copyright © 2023 Manager. All rights reserved.
//

import Foundation
import CoreData
import Resources

final class CoreDataService {
    
    private let persistentContainer: NSPersistentContainer
    private var entity: NSEntityDescription?
    
    init(with xcdatamodeld: String, entityName: String) {
//        self.persistentContainer = .init(name: "ScanModel")
        self.persistentContainer = .init(name: xcdatamodeld)
        self.loadPersistentStore(with: entityName)
    }
    
//    lazy var entity: NSEntityDescription? = .entity(forEntityName: "ScanedWriting", in: self.container.viewContext)
    
    @discardableResult
    func saveData(with dataDic: [String: Any]) -> Bool {
        guard let entity else {
            print("NSEntityDescription not initialized")
            return false
        }
        
        let context: NSManagedObjectContext = persistentContainer.viewContext
        let modelData: NSManagedObject = .init(entity: entity, insertInto: context)
        dataDic.forEach {
            modelData.setValue($0.value, forKey: $0.key)
        }
        
        do {
            try context.save()
            return true
            
        } catch {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchData<T: NSManagedObject>() -> [T] {
        guard let request = T.fetchRequest() as? NSFetchRequest<T> else {
            return []
        }
        
        do {
            let fetchResult = try persistentContainer.viewContext.fetch(request)
            return fetchResult
            
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    @discardableResult
    func deleteData(object: NSManagedObject) -> Bool {
        persistentContainer.viewContext.delete(object)
        
        do {
            try persistentContainer.viewContext.save()
            return true
            
        } catch {
            return false
        }
    }
}

private extension CoreDataService {
    
    func loadPersistentStore(with entityName: String) {
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error {
                // FIXME: Log 구현 필요
                print("Unresolved error \(error.localizedDescription)")
                return
            }
            
            self.entity = .entity(forEntityName: entityName, in: self.persistentContainer.viewContext)
        })
    }
}
