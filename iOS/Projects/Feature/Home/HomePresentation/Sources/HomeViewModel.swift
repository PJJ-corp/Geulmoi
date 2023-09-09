//
//  HomeViewModel.swift
//  HomePresentation
//
//  Created by Lee, Joon Woo on 2023/08/20.
//  Copyright © 2023 HomePresentation. All rights reserved.
//

import MVVMInterface

import Foundation

public protocol HomeViewModelNavigation: AnyObject {

    func nextScene()
}

public final class HomeViewModel: ViewModel {
    
    public struct Input { }
    
    public struct Output { }
    
    public let input = Input()
    public let output = Output()
    
    public init(navigator: HomeViewModelNavigation? = nil) {
        self.navigator = navigator
    }
    
    private weak var navigator: HomeViewModelNavigation?
    
    /// 임시로 코디네이터 함수 호출 확인하기 위함
    func temporaryCallCoordinatorActionIndirectly() {
        print("뷰컨트롤러에서 받은 액션 코디네이터로 전달")
        self.navigator?.nextScene()
    }
    
}
