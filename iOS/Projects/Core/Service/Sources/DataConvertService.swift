//
//  DataConvertService.swift
//  Service
//
//  Created by juntaek.oh on 2023/10/09.
//  Copyright © 2023 Service. All rights reserved.
//

import UIKit

struct DataConvertService {
    
    static func convertToUIImage(from data: Data) -> UIImage? {
        return .init(data: data)
    }
    
    static func convertToCGImage(from data: Data) -> CGImage? {
        let image: UIImage? = DataConvertService.convertToUIImage(from: data)
        
        return image?.cgImage
    }
}
