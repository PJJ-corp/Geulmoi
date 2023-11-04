//
//  PhotoPreviewViewController.swift
//  HomePresentation
//
//  Created by Jihee hwang on 2023/11/03.
//  Copyright © 2023 HomePresentation. All rights reserved.
//

import UIKit
import MVVMInterface
import SnapKit
import RxSwift
import RxCocoa

public final class PhotoPreviewViewController: UIViewController, View {
    
    private lazy var photoPreview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Initializer

    public init(with photo: Data) {
        super.init(nibName: nil, bundle: nil)

        showPreview(photo)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    public func bind(to viewModel: PhotoPreviewViewModel) {
        
    }
    
    private func showPreview(_ data: Data) {
        guard let image = UIImage(data: data) else { return }
        photoPreview.image = image
    }
    
}

// MARK: - configure UI

extension PhotoPreviewViewController {
    
    private func configureUI() {
        view.addSubview(photoPreview)
        
        photoPreview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
