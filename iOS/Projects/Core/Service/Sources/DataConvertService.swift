//
//  DataConvertService.swift
//  Service
//
//  Created by juntaek.oh on 2023/10/09.
//  Copyright © 2023 Service. All rights reserved.
//

import UIKit

public struct DataConvertService {
    
    public static func convertToUIImage(from data: Data) -> UIImage? {
        return .init(data: data)
    }
    
    public static func convertToCGImage(from data: Data) -> CGImage? {
        let image: UIImage? = DataConvertService.convertToUIImage(from: data)
        
        return image?.cgImage
    }
}
