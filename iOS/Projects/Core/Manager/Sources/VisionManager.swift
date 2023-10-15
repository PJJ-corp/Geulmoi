//
//  VisionManager.swift
//  Manager
//
//  Created by juntaek.oh on 2023/10/09.
//  Copyright © 2023 Manager. All rights reserved.
//

import UIKit
import Vision
import Service
import RxSwift
import RxRelay

final public class VisionManager {
    
    private var vnTextRequest: VNRecognizeTextRequest?
    private var vnRequestHandlers: [VNImageRequestHandler] = []
    
    public let convertedTextRelay: BehaviorRelay<String> = .init(value: "")
    
    init() {
        self.configureVnRequest()
        self.setVnRequestOptions()
    }
    
    public func executeVisionOcr(with datas: [Data]) {
        self.vnRequestHandlers = datas.compactMap {
            return .init(data: $0)
        }
        
        guard vnRequestHandlers.count == datas.count else { return }
        
        do {
            guard let vnTextRequest else { return }
            
            defer {
                self.vnRequestHandlers.removeAll()
            }
            
            // Request 실행
            try self.vnRequestHandlers.forEach {
                try $0.perform([vnTextRequest])
            }
            
        } catch {
            print("Execute Error: \(error.localizedDescription)")
        }
    }
}

private extension VisionManager {
    
    func configureVnRequest() {
        self.vnTextRequest = .init { [weak self] request, error in
            guard let self, let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            if let error {
                print("Request Error: \(error.localizedDescription)")
                
                return
            }
            
            let text = observations
                .compactMap {
                    $0.topCandidates(1).first?.string
                }
                .map {
                    if $0.last == "." || $0.last == "\"" {
                        let newChar: String = $0 + " "
                        return newChar
                    }
                    
                    return $0
                }
                .joined()
            
            self.convertedTextRelay.accept(text)
        }
    }
    
    func setVnRequestOptions() {
        if #available(iOS 16.0, *) {
            // 최신 Vision으로 할당
            let revision3: Int = VNRecognizeTextRequestRevision3
            self.vnTextRequest?.revision = revision3
        }
        
        // 속도와 정확도 중에서 선택 가능
        self.vnTextRequest?.recognitionLevel = .accurate
        self.vnTextRequest?.recognitionLanguages = ["ko-KR"]
        self.vnTextRequest?.usesLanguageCorrection = true
    }
}
