//
//  SharedExampleSource.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/22.
//

import Foundation

public protocol View: AnyObject {
    associatedtype ViewModelType: ViewModel
    
    func bind(to viewModel: ViewModelType)
}
