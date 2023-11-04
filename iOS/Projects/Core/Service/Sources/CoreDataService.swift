//
//  CoreDataManager.swift
//  Manager
//
//  Created by juntaek.oh on 2023/11/04.
//  Copyright © 2023 Manager. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataService {
    
    private let persistentContainer: NSPersistentContainer
    private var entity: NSEntityDescription?
    
    init(with xcdatamodeld: String, entityName: String) {
//        self.persistentContainer = .init(name: "ScanModel")
        self.persistentContainer = .init(name: xcdatamodeld)
        self.loadPersistentStore(with: entityName)
    }
    
//    lazy var entity: NSEntityDescription? = .entity(forEntityName: "ScanedWriting", in: self.container.viewContext)
    
    func saveData(with dataDic: [String: Any]) {
        guard let entity else {
            print("NSEntityDescription not initialized")
            return
        }
        
        let context: NSManagedObjectContext = persistentContainer.viewContext
        let modelData: NSManagedObject = .init(entity: entity, insertInto: context)
        dataDic.forEach {
            modelData.setValue($0.value, forKey: $0.key)
        }
        
        do {
            try context.save()
            
        } catch {
            print("Error: \(error.localizedDescription)")
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
