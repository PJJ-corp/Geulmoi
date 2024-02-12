//
//  CameraManager.swift
//  HomePresentation
//
//  Created by Jihee hwang on 2024/02/12.
//  Copyright © 2024 HomePresentation. All rights reserved.
//

import UIKit

import AVFoundation
import Photos

public protocol CameraManagable: AnyObject {
    func prepareCapturing(with previewLayerView: UIView)
    func flipCamera()
    func shoot(completionHandler: @escaping (PhotoOutputResultType) -> Void)
    func changeUseFrontCameraOrNot()
    func endCapturing()
}

public final class CameraManager: CameraManagable {
    
    // MARK: - Property
    
    private var photoSettings = AVCapturePhotoSettings()
    private var captureInput: AVCaptureInput?
    private let captureOutput = AVCapturePhotoOutput()
    private let captureSession: AVCaptureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue.global(qos: .background)
    private let delegate = PhotoCaptureDelegate()

    private lazy var previewLayer = AVCaptureVideoPreviewLayer()
    
    private var usingFrontCamera = false
    private var isCaptureSessionSetup = false
    
    private var completion: ((PhotoOutputResultType) -> Void)? {
        didSet {
            delegate.completionHandler = completion
        }
    }
    
    // MARK: - Init & Deinit
    
    public init() { }
    
    deinit {
        guard captureSession.isRunning else {
            return
        }
        
        endCapturing()
    }
    
    // MARK: - CameraManagable
    
    public func prepareCapturing(with previewLayerView: UIView) {
        setupPreviewLayer(with: previewLayerView)
        setupCaptureSession()
    }
    
    public func flipCamera() {
        guard let captureInput else { return }
        
        captureSession.beginConfiguration()
        captureSession.removeInput(captureInput)
        setupInput()
        captureSession.commitConfiguration()
    }
    
    public func shoot(completionHandler: @escaping (PhotoOutputResultType) -> Void)  {
        let settings = photoCaptureSettings()
        captureOutput.capturePhoto(with: settings, delegate: delegate)
        
        completion = completionHandler
    }
    
    public func changeUseFrontCameraOrNot() {
        usingFrontCamera.toggle()
        isCaptureSessionSetup = false
    }
    
    public func endCapturing() {
        captureSession.stopRunning()
    }
    
}

extension CameraManager {
    
    private func setupPreviewLayer(with previewLayerView: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.videoGravity = .resizeAspectFill
            self.previewLayer.frame = previewLayerView.bounds
            previewLayerView.layer.addSublayer(self.previewLayer)
        }
    }
    
    private func setupCaptureSession() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            
            if !self.isCaptureSessionSetup { self.setupInput() }
            
            self.startCamera()
        }
        
        setupOutput()
        captureSession.commitConfiguration()
        isCaptureSessionSetup = true
    }
    
    private func setupInput() {
        let cameraPosition: AVCaptureDevice.Position = usingFrontCamera ? .front : .back

        guard let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: cameraPosition
        ) else {
            fatalError("no camera")
        }
       
        guard let cameraInput = try? AVCaptureDeviceInput(device: device)
        else {
            fatalError("could not create input device")
        }
        
        captureInput = cameraInput
        
        guard captureSession.canAddInput(cameraInput)
        else {
            fatalError("could not add camera input to capture session")
        }
        
        captureSession.addInput(cameraInput)
    }
    
    private func setupOutput() {
        captureSession.removeOutput(captureOutput)
        
        guard captureSession.canAddOutput(captureOutput)
        else {
            fatalError("could not add video output")
        }
        
        captureSession.addOutput(captureOutput)
        previewLayer.connection?.videoOrientation = .portrait
    }
    
    private func startCamera() {
        if !captureSession.isRunning {
            sessionQueue.async { [weak self] in
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                
                switch status {
                case .notDetermined, .restricted, .denied:
                    self?.captureSession.stopRunning()
                    
                case .authorized:
                    self?.captureSession.startRunning()
                default:
                    fatalError("unknown default reached. Check code.")
                }
            }
        }
    }
    
    private func photoCaptureSettings() -> AVCapturePhotoSettings {
        var settings = AVCapturePhotoSettings()
        settings.isHighResolutionPhotoEnabled = true

        settings = captureOutput.availablePhotoCodecTypes.contains(.hevc) ?
        AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc]) :
        AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])

        return settings
    }
    
}
