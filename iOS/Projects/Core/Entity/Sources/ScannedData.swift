//
//  ScanedModel.swift
//  Entity
//
//  Created by juntaek.oh on 2024/01/13.
//  Copyright © 2024 Entity. All rights reserved.
//

import Foundation

public struct ScannedData: CoreDataModel, Codable {
    
    public let uuid: String
    public let imageData: Data
    public let text: String
    
    public init(uuid: String, imageData: Data, text: String) {
        self.uuid = uuid
        self.imageData = imageData
        self.text = text
    }
}
