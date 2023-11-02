//
//  PhotoConfirmView.swift
//  HomePresentation
//
//  Created by Jihee hwang on 2023/11/02.
//  Copyright © 2023 HomePresentation. All rights reserved.
//

import UIKit
import SnapKit
import Photos

final class PhotoConfirmView: UIView {
    
    // MARK: - Views
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - configure UI

extension PhotoConfirmView {
    
    private func configureUI() {
        addSubview(closeButton)

    }
    
}
