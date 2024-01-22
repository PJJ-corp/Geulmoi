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

public final class CoreDataService {
    
    private var persistentContainer: NSPersistentContainer?
    private var entity: NSEntityDescription?
    
    public var isInitialized: Bool {
        return ((entity != nil) && (persistentContainer != nil))
    }
    
    public init(with xcdatamodeld: String, entityName: String) {
        self.loadPersistentStore(with: xcdatamodeld, entityName: entityName)
    }
    
    public func saveData(with dataDic: [String: Any]) throws { // 공용 사용을 위해 JSON 형태로 데이터를 받도록 구현
        guard let persistentContainer, let entity else {
            print("Essetensial properties not initialized")
            return
        }
        
        let context: NSManagedObjectContext = persistentContainer.viewContext
        let modelData: NSManagedObject = .init(entity: entity, insertInto: context)
        dataDic.forEach {
            modelData.setValue($0.value, forKey: $0.key)
        }
        
        try context.save()
    }
    
    public func fetchData<T: NSManagedObject>() throws -> [T] {
        guard let persistentContainer, let request = T.fetchRequest() as? NSFetchRequest<T> else {
            print("Essetensial properties not initialized")
            return []
        }
        
        let fetchResult = try persistentContainer.viewContext.fetch(request)
        return fetchResult
    }
    
    public func deleteData(object: NSManagedObject) throws {
        guard let persistentContainer else {
            print("Not exist container")
            return
        }
        
        persistentContainer.viewContext.delete(object)
        
        try persistentContainer.viewContext.save()
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
