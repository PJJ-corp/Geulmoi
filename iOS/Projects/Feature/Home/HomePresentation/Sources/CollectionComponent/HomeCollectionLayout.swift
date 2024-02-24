//
//  HomeCollectionLayout.swift
//  HomePresentation
//
//  Created by juntaek.oh on 2024/02/24.
//  Copyright © 2024 HomePresentation. All rights reserved.
//

import UIKit

struct HomeCollectionLayout {
    
    var mainLayoutSection: UICollectionViewCompositionalLayout? {
        guard let collectionLayout = self.createMainLayout() else { return nil }
        
        return .init(section: collectionLayout)
    }
    
    var photoLayoutSection: UICollectionViewCompositionalLayout? {
        guard let collectionLayout = self.createPhotoLayout() else { return nil }
        
        return .init(section: collectionLayout)
    }
    
    var textLayoutSection: UICollectionViewCompositionalLayout? {
        guard let collectionLayout = self.createMainLayout() else { return nil }
        
        return .init(section: collectionLayout)
    }
}

private extension HomeCollectionLayout {
    
    func createMainLayout() -> NSCollectionLayoutSection? {
        let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(560))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createPhotoLayout() -> NSCollectionLayoutSection? {
        let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createTextLayout() -> NSCollectionLayoutSection? {
        let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
