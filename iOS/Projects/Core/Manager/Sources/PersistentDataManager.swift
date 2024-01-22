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
    
    public func saveCoreData<T: CoreDataModel>(with type: CoreDataType, model: T) {
        guard let service: CoreDataService = coreDataServices[type] else {
            return
        }
        
        let json: [String: Any] = self.convertDataToDictionary(with: type, model: model)
        
        do {
            try service.saveData(with: json)
            
        } catch {
            // FIXME: OSLog
            print("Error: \(error.localizedDescription)")
        }
    }
    
    public func fetchCoreData(with type: CoreDataType) -> [CoreDataModel] {
        guard let service: CoreDataService = coreDataServices[type] else {
            return []
        }
        
        switch type {
        case .scanedWriting:
            var convertedModel: [ScannedData] = []
            
            do {
                let fetchedData: [ScanedWriting] = try service.fetchData()
                
                self.fetchedDatas[type] = fetchedData
                fetchedData.forEach {
                    guard let uuid = $0.uuid, let imageData = $0.imageData, let text = $0.text else {
                        // FIXME: Log
                        print("Saved data does not have essential property value")
                        return
                    }
                    
                    let model: ScannedData = .init(uuid: uuid, imageData: imageData, text: text)
                    convertedModel.append(model)
                }
                
                return convertedModel
                
            } catch {
                // FIXME: OSLog
                print("Error: \(error.localizedDescription)")
                return convertedModel
            }
        }
    }
    
    public func removeCoreData<T: CoreDataModel>(with type: CoreDataType, model: T) {
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
            
            do {
                try service.deleteData(object: deleteData[0])
                
            } catch {
                // FIXME: OSLog
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

private extension PersistentDataManager {
    
    // Serialization으로 json 형태로 변환하면 Data 타입이 String 타입으로 변환되어 Manager 객체에 전용 변환 함수 구현
    func convertDataToDictionary<T: CoreDataModel>(with type: CoreDataType, model: T) -> [String: Any] {
        var json: [String: Any] = [:]
        
        switch type {
        case .scanedWriting:
            guard let convedtedModel = model as? ScannedData else {
                return json
            }
            
            json["uuid"] = convedtedModel.uuid
            json["imageData"] = convedtedModel.imageData
            json["text"] = convedtedModel.text
            
            return json
        }
    }
}
