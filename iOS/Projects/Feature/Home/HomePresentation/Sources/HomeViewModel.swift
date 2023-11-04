//
//  HomeViewModel.swift
//  HomePresentation
//
//  Created by Lee, Joon Woo on 2023/08/20.
//  Copyright © 2023 HomePresentation. All rights reserved.
//

import Foundation
import MVVMInterface
import RxSwift
import RxCocoa

public protocol HomeViewModelNavigation: AnyObject {

    func showPhotoPreview(with photoData: Data)
}

public final class HomeViewModel: ViewModel {
    
    public struct Input {
        let photoData = PublishRelay<Data>()
    }
    
    public struct Output { }
    
    public let input = Input()
    public let output = Output()
    
    // MARK: - Property
    
    private weak var navigator: HomeViewModelNavigation?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    public init(navigator: HomeViewModelNavigation? = nil) {
        self.navigator = navigator
        
        bind()
    }
    
    // MARK: - Function
    
    private func bind() {
        input.photoData
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, data in
                owner.navigator?.showPhotoPreview(with: data)
            })
            .disposed(by: disposeBag)
    }
    
}
