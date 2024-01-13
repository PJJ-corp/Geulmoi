//
//  ScanedModel.swift
//  Entity
//
//  Created by juntaek.oh on 2024/01/13.
//  Copyright © 2024 Entity. All rights reserved.
//

import Foundation

struct ScanedModel: CoreDatable {
    
    let uuid: String
    let imageData: Data
    let text: String
}
