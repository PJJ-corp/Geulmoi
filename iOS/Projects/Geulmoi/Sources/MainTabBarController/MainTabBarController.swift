//
//  MainTabBarController.swift
//  Geulmoi
//
//  Created by Lee, Joon Woo on 1/12/24.
//  Copyright © 2024 Geulmoi. All rights reserved.
//

import UIKit
import Resources

final class MainTabBarController: UITabBarController {
    
    private lazy var customTabbar: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ResourcesAsset.Colors.ivory.color
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var middleButton: UIButton = {
        let middleIndex = 2
        
        let button = CustomTabbarButton(index: middleIndex)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ResourcesAsset.Colors.khaki.color
        button.clipsToBounds = false
        button.layer.borderWidth = 10
        button.layer.borderColor = ResourcesAsset.Colors.ivory.color.cgColor
                
        button.addAction(UIAction { [weak self] _ in
            self?.selectedIndex = middleIndex
        }, for: .touchUpInside)
        
        return button
    }()
    
    private var selectedIndexObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setViewControllers()
        self.createSelectedIndexObservation()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        self.setCustomTabbar()
        
        self.customTabbar.layer.cornerRadius = 10
        self.middleButton.layer.cornerRadius = 35.5
        
        self.selectedIndex = 0
    }
    
    private func createSelectedIndexObservation() {
                
        self.selectedIndexObservation = self.observe(\.selectedIndex, options: [.new]) { [weak self] _, change in
            guard 
                let own = self,
                let updatedIndex = change.newValue 
            else { return }

            var allButtons: [Int:CustomTabbarButton] = [:]
            allButtons[2] = own.middleButton as? CustomTabbarButton
            
            own.customTabbar.subviews.enumerated().forEach { index, button in
                if let button =  button as? CustomTabbarButton {
                    allButtons[index] = button
                }
            }
            
            allButtons.values.forEach { $0.isSelected = false }

            allButtons[updatedIndex]?.isSelected = true
        }
    }
    
    private func disableAllOriginalTabbarItems() {
        
        self.viewControllers?.forEach {
            $0.tabBarItem.isEnabled = false
        }
    }
    
    private func setViewControllers() {
        
        let first = UIViewController()
        first.view.backgroundColor = .white
        
        let second = UIViewController()
        second.view.backgroundColor = .systemRed
        
        let third = UIViewController()
        third.view.backgroundColor = .systemBlue
        
        let forth = UIViewController()
        forth.view.backgroundColor = .systemBrown
        
        let fifth = UIViewController()
        fifth.view.backgroundColor = .systemPink
        
        self.viewControllers = [first, second, third, forth, fifth]
    }
    
    private func setCustomTabbar() {
        guard let viewControllers = self.viewControllers else { return }
        
        self.view.addSubview(self.customTabbar)
        self.view.addSubview(self.middleButton)
        
        let numberOfViewControllers = CGFloat(viewControllers.count)
        let customTabbarButtonWidth = (self.view.bounds.width - 40) / numberOfViewControllers
        
        viewControllers.enumerated().forEach { index, viewController in
            if let customTabbarButton = self.createCustomTabbarButton(index: index) {
                customTabbarButton.widthAnchor.constraint(equalToConstant: customTabbarButtonWidth).isActive = true
                self.customTabbar.addArrangedSubview(customTabbarButton)
            } else {
                self.customTabbar.addArrangedSubview(UIView())
            }
        }
        
        NSLayoutConstraint.activate([
            self.customTabbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.customTabbar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.customTabbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -23),
            self.customTabbar.heightAnchor.constraint(equalToConstant: 60),
            
            self.middleButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            self.middleButton.bottomAnchor.constraint(equalTo: self.customTabbar.bottomAnchor, constant: -10),
            self.middleButton.widthAnchor.constraint(equalToConstant: 70),
            self.middleButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func createCustomTabbarButton(index: Int) -> CustomTabbarButton? {
        
        let isMiddle = index == 2
        if isMiddle { return nil }
        
        let button = CustomTabbarButton(index: index)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ResourcesAsset.Colors.ivory.color
        
        button.addAction(UIAction { [weak self] _ in
            self?.selectedIndex = index
        }, for: .touchUpInside)
        
        return button
    }
}
