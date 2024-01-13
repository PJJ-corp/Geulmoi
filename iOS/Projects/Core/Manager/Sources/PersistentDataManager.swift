//
//  PersistentDataManager.swift
//  Manager
//
//  Created by juntaek.oh on 2023/11/04.
//  Copyright © 2023 Manager. All rights reserved.
//

import Foundation
import Service
import Resources
import Entity

// MARK: LocalData 관리용
public final class PersistentDataManager {
    
    public enum CoreDataType: CaseIterable {
        case scanedWriting
        
        var modelId: String {
            switch self {
            case .scanedWriting:
                return "ScanModel"
            }
        }
        
        var entityId: String {
            switch self {
            case .scanedWriting:
                return "ScanedWriting"
            }
        }
    }
    
    public static let shared: PersistentDataManager = .init()
    
    private var coreDataServices: [CoreDataType: CoreDataService] = [:]
    private var fetchedDatas: [CoreDataType: [Any]] = [:]
    
    private init() {
        CoreDataType.allCases.forEach {
            self.coreDataServices[$0] = .init(with: $0.modelId, entityName: $0.entityId)
        }
    }
    
    public func saveCoreData<T: Codable>(with type: CoreDataType, model: T) {
        guard let service: CoreDataService = coreDataServices[type], let json = DataConvertService.convertToJson(from: model) else {
            return
        }
        
        let isSaved: Bool = service.saveData(with: json)
        
        if isSaved {
            // FIXME: Log
            print("Save Data to CoreData is Succeed")
        } else {
            print("Save Data to CoreData is Failed")
        }
    }
    
    public func fetchCoreData(with type: CoreDataType) -> [CoreDatable] {
        guard let service: CoreDataService = coreDataServices[type] else {
            return []
        }
        
        switch type {
        case .scanedWriting:
            var convertedModel: [ScanedModel] = []
            let fetchedData: [ScanedWriting] = service.fetchData()
            
            self.fetchedDatas[type] = fetchedData
            fetchedData.forEach {
                guard let uuid = $0.uuid, let imageData = $0.imageData, let text = $0.text else {
                    // FIXME: Log
                    print("Saved data does not have essential property value")
                    return
                }
                
                let model: ScanedModel = .init(uuid: uuid, imageData: imageData, text: text)
                convertedModel.append(model)
            }
            
            return convertedModel
        }
    }
    
    public func removeCoreData<T: CoreDatable>(with type: CoreDataType, model: T) {
        guard let service: CoreDataService = coreDataServices[type], let datas = self.fetchedDatas[type] else {
            return
        }
        
        switch type {
        case .scanedWriting:
            let deleteData: [ScanedWriting] = datas
                .compactMap { $0 as? ScanedWriting }
                .filter { $0.uuid == model.uuid }
            
            guard deleteData.count == 1 else {
                // FIXME: Log
                print("Model Id duplicated")
                return
            }
            
            service.deleteData(object: deleteData[0])
            // FIXME: Log
            print("Delete data successly")
        }
    }
}
