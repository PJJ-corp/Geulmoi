//
//  PhotoPreviewViewModel.swift
//  HomePresentation
//
//  Created by Jihee hwang on 2023/11/04.
//  Copyright © 2023 HomePresentation. All rights reserved.
//

import Foundation
import MVVMInterface
import RxSwift
import RxCocoa

public protocol PhotoPreviewViewModelNavigation: AnyObject {

    func showTransferView()
}

public final class PhotoPreviewViewModel: ViewModel {
    
    public struct Input {
        let photoData = PublishRelay<Data>()
    }
    
    public struct Output { }
    
    public let input = Input()
    public let output = Output()
    
    // MARK: - Property
    
    private weak var navigator: PhotoPreviewViewModelNavigation?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    public init(navigator: PhotoPreviewViewModelNavigation? = nil) {
        self.navigator = navigator
        
        bind()
    }
    
    // MARK: - Function
    
    private func bind() {

    }
    
}
