//
//  MainCell.swift
//  HomePresentation
//
//  Created by juntaek.oh on 2024/02/24.
//  Copyright © 2024 HomePresentation. All rights reserved.
//

import Then
import Snapkit

class MainCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "MainCell"
    

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLayouts()
        configureAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure(data: Any) {
        
    }
}

private extension StationCell {
    
    func configureLayouts() {
        
    }
    
    func configureAction() {
        
    }
}
