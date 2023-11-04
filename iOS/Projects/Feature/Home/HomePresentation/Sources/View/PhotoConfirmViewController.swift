//
//  PhotoConfirmViewController.swift
//  HomePresentation
//
//  Created by Jihee hwang on 2023/11/03.
//  Copyright © 2023 HomePresentation. All rights reserved.
//

import UIKit
import MVVMInterface
import SnapKit
import Photos

public final class PhotoConfirmViewController: UIViewController, View {

    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Function
    
    public func bind(to viewModel: HomeViewModel) {
        print("바인딩 후 코디네이터로 액션 전달되는 지 확인")
        viewModel.temporaryCallCoordinatorActionIndirectly()
    }
    
}

// MARK: - configure UI

extension PhotoConfirmViewController {
    
    private func configureUI() {
        
    }
    
}
