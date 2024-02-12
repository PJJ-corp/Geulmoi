//
//  PhotoCaptureDelegate.swift
//  HomePresentation
//
//  Created by Jihee hwang on 2024/02/12.
//  Copyright © 2024 HomePresentation. All rights reserved.
//

import Foundation
import Photos

// MARK: - PhotoOutputResultType

public enum PhotoOutputResultType {
    case success(with: Data)
    case fail
}

// MARK: - PhotoCaptureDelegate

final class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    
    var completionHandler: ((PhotoOutputResultType) -> Void)?
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil,
              let originalImageData = photo.fileDataRepresentation()
        else {
            completionHandler?(.fail)
            return
        }
        
        PHPhotoLibrary.requestAuthorization ({ [weak self] status in
            guard let self else { return }
            
            guard status == .authorized else {
                self.completionHandler?(.fail)
                return
            }
            
            self.completionHandler?(.success(with: originalImageData))
        })
    }
}
