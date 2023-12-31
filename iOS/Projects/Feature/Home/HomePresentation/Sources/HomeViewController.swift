//
//  HomePresentation.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import UIKit
import MVVMInterface

public final class HomeViewController: UIViewController, View {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
    }
    
    public func bind(to viewModel: HomeViewModel) {
        print("바인딩 후 코디네이터로 액션 전달되는 지 확인")
        viewModel.temporaryCallCoordinatorActionIndirectly()
    }
}
