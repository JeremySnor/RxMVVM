//
//  CollectionViewConnector.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

public class CollectionViewConnector {
    
    public static func reloadDataSource<VM, C: CollectionViewCell<VM>, Section>(_ cellType: C.Type) -> RxCollectionViewSectionedReloadDataSource<SectionModel<Section, VM>> {
        return RxCollectionViewSectionedReloadDataSource(configureCell: { _, collectionView, indexPath, viewModel in
            return dequeueCell(cellType, collectionView: collectionView, viewModel: viewModel, indexPath: indexPath)
        })
    }
    public static func reloadDataSource<B: CellBlockProtocol, Section>(_ blockType: B.Type) -> RxCollectionViewSectionedReloadDataSource<SectionModel<Section, B>> {
        return RxCollectionViewSectionedReloadDataSource(configureCell: { _, collectionView, indexPath, block in
            return dequeueCell(block: block, collectionView: collectionView, indexPath: indexPath)
        })
    }
    public static func animatedDataSource<VM: IdentifiableType, C: CollectionViewCell<VM>>(_ cellType: C.Type) -> RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, VM>> {
        return RxCollectionViewSectionedAnimatedDataSource(configureCell: { _, collectionView, indexPath, viewModel in
            return dequeueCell(cellType, collectionView: collectionView, viewModel: viewModel, indexPath: indexPath)
        })
    }
    
    public static func animatedDataSource<B: CellBlockProtocol & IdentifiableType>(_ blockType: B.Type) -> RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, B>> {
        return RxCollectionViewSectionedAnimatedDataSource(configureCell: { _, collectionView, indexPath, block in
            return dequeueCell(block: block, collectionView: collectionView, indexPath: indexPath)
        })
    }
    
    public static func register<B: CellBlockProtocol>(_  blockType: B.Type, for collectionView: UICollectionView) {
        register(identifiers: blockType.allCellIdentifier, for: collectionView)
    }
    public static func register<C: CellProtocol>(_ cellType: C.Type, for collectionView: UICollectionView) {
        register(identifiers: [cellType.cellIdentifier], for: collectionView)
    }
    
}

fileprivate extension CollectionViewConnector {
    
    static func dequeueCell<VM, C: CollectionViewCell<VM>>(_ cellType: C.Type, collectionView: UICollectionView, viewModel: VM, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.cellIdentifier, for: indexPath) as! CellProtocol
        cell.set(viewModel: viewModel)
        return cell as! UICollectionViewCell
    }
    static func dequeueCell<B: CellBlockProtocol>(block: B, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: block.cellIdentifier, for: indexPath) as! CellProtocol
        cell.set(viewModel: block.cellViewModel)
        return cell as! UICollectionViewCell
    }
    private static func register(identifiers: [String], for collectionView: UICollectionView) {
        for identifier in identifiers {
            collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
    
}
