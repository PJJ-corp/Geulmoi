//
//  CustomTabbarButton.swift
//  Geulmoi
//
//  Created by Lee, Joon Woo on 1/15/24.
//  Copyright © 2024 Geulmoi. All rights reserved.
//

import UIKit
import Resources

final class CustomTabbarButton: UIButton {
    
    let index: Int
    
    init(index: Int) {
        self.index = index
        super.init(frame: .zero)
        
        let imageSet = self.image(for: self.index)
        self.setImage(imageSet?.normal, for: .normal)
        self.setImage(imageSet?.selected, for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let imageRect = imageView?.frame ?? CGRect.zero
        
        let centerX = imageRect.midX
        let centerY = imageRect.midY
        let width = imageRect.width * 1.5
        let height = imageRect.height * 1.5

        let expandedFrame = CGRect(
            x: centerX - width / 2,
            y: centerY - height / 2,
            width: width,
            height: height
        )
        
        return expandedFrame.contains(point)
    }
    
    private func image(for index: Int) -> (normal: UIImage, selected: UIImage)? {
        
        switch index {
        case 0:
            return (
                normal: ResourcesAsset.Images.feedNormal.image,
                selected: ResourcesAsset.Images.feedSelected.image
            )
        case 1:
            return (
                normal: ResourcesAsset.Images.textNormal.image,
                selected: ResourcesAsset.Images.textSelected.image
            )
        case 2:
            return (
                normal: ResourcesAsset.Images.cameraNormal.image,
                selected: ResourcesAsset.Images.cameraNormal.image
            )
        case 3:
            return (
                normal: ResourcesAsset.Images.exchangeNormal.image,
                selected: ResourcesAsset.Images.exchangeSelected.image
            )
        case 4:
            return (
                normal: ResourcesAsset.Images.settingNormal.image,
                selected: ResourcesAsset.Images.settingSelected.image
            )
        default:
            return nil
        }
    }
}
