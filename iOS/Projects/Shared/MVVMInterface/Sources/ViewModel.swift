//
//  ViewModel.swift
//  MVVMInterface
//
//  Created by Lee, Joon Woo on 2023/08/07.
//  Copyright © 2023 MVVMInterface. All rights reserved.
//

import Foundation

public protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
