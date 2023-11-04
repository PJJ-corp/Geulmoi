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
    
    private var persistentContainer: NSPersistentContainer?
    private var entity: NSEntityDescription?
    
    var isInitialized: Bool {
        return ((entity != nil) && (persistentContainer != nil))
    }
    
    init(with xcdatamodeld: String, entityName: String) {
        self.loadPersistentStore(with: xcdatamodeld, entityName: entityName)
    }
    
    @discardableResult
    func saveData(with dataDic: [String: Any]) -> Bool {
        guard let persistentContainer, let entity else {
            print("Essetensial properties not initialized")
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
        guard let persistentContainer, let request = T.fetchRequest() as? NSFetchRequest<T> else {
            print("Essetensial properties not initialized")
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
        guard let persistentContainer else {
            print("Not exist container"
            return false
        }
        
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
    
    func loadPersistentStore(with xcdatamodeld:String, entityName: String) {
        guard let modelUrl = Bundle.init(identifier: "com.Geulmoi.Resources")?.url(forResource: xcdatamodeld, withExtension: "momd") else {
            print("Error loading model from bundle")
            return
        }

        guard let objectModel = NSManagedObjectModel(contentsOf: modelUrl) else {
            print("Error initializing model from: \(modelUrl)")
            return
        }
        
        persistentContainer = .init(name: xcdatamodeld, managedObjectModel: objectModel)
        persistentContainer?.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error {
                // FIXME: Log 구현 필요
                print("Load persistentStore error: \(error.localizedDescription)")
                return
            }
            
            self.entity = .entity(forEntityName: entityName, in: self.persistentContainer!.viewContext)
        })
    }
}
