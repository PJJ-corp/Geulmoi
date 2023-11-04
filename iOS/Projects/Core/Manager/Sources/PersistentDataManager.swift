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
    
    private init() {
        CoreDataType.allCases.forEach {
            self.coreDataServices[$0] = .init(with: $0.modelId, entityName: $0.entityId)
        }
    }
    
    public func saveCoreData<T: Codable>(with type: CoreDataType, data: T) {
        guard let service: CoreDataService = coreDataServices[type], let json = DataConvertService.convertToJson(from: data) else {
            return
        }
        
        let isSaved: Bool = service.saveData(with: json)
        if !isSaved {
            // FIXME: Log
            print("Save Data to CoreData is Failed")
        }
    }
    
    public func fetchCoreData(with type: CoreDataType) -> [Any] {
        guard let service: CoreDataService = coreDataServices[type] else {
            return []
        }
        
        switch type {
        case .scanedWriting:
            let fetchedData: [ScanedWriting] = service.fetchData()
            // TODO: DTO 생성 및 변환해서 던져주기
            return fetchedData
        }
    }
    
    public func removeCoreData(with type: CoreDataType) { // 받을 DTO는 Key나 숫자를 가지고 있고, 객체에서 이걸로 ManagedObject 가지고 판별하도록 구현 필요
        guard let service: CoreDataService = coreDataServices[type] else {
            return
        }
        
        // TODO: Fetch Object
    }
}
