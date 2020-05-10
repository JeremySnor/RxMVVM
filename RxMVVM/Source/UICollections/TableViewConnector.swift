//
//  TableViewConnector.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

public class TableViewConnector {
    
    public static func reloadTableViewDataSource<VM, C: TableViewCell<VM>, Section>(_ cellType: C.Type) -> RxTableViewSectionedReloadDataSource<SectionModel<Section, VM>> {
        return RxTableViewSectionedReloadDataSource(configureCell: { _, tableView, indexPath, viewModel in
            return dequeueCell(cellType, tableView: tableView, viewModel: viewModel, indexPath: indexPath)
        })
    }
    public static func reloadTableViewDataSource<B: CellBlockProtocol, Section>(_ blockType: B.Type) -> RxTableViewSectionedReloadDataSource<SectionModel<Section, B>> {
        return RxTableViewSectionedReloadDataSource(configureCell: { _, tableView, indexPath, block in
            return dequeueCell(block: block, tableView: tableView, indexPath: indexPath)
        })
    }
    public static func animatedTableViewDataSource<VM: IdentifiableType, C: TableViewCell<VM>>(_ cellType: C.Type) -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, VM>> {
        return RxTableViewSectionedAnimatedDataSource(configureCell: { _, tableView, indexPath, viewModel in
            return dequeueCell(cellType, tableView: tableView, viewModel: viewModel, indexPath: indexPath)
        })
    }
    
    public static func animatedTableViewDataSource<B: CellBlockProtocol & IdentifiableType>(_ blockType: B.Type) -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, B>> {
        return RxTableViewSectionedAnimatedDataSource(configureCell: { _, tableView, indexPath, block in
            return dequeueCell(block: block, tableView: tableView, indexPath: indexPath)
        })
    }
    
    public static func register<B: CellBlockProtocol>(_  blockType: B.Type, for tableView: UITableView) {
        register(identifiers: blockType.allCellIdentifier, for: tableView)
    }
    public static func register<C: CellProtocol>(_ cellType: C.Type, for tableView: UITableView) {
        register(identifiers: [cellType.cellIdentifier], for: tableView)
    }
    
    
}

fileprivate extension TableViewConnector {
    
    static func dequeueCell<VM, C: TableViewCell<VM>>(_ cellType: C.Type, tableView: UITableView, viewModel: VM, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier, for: indexPath) as! CellProtocol
        cell.set(viewModel: viewModel)
        return cell as! UITableViewCell
    }
    static func dequeueCell<B: CellBlockProtocol>(block: B, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: block.cellIdentifier, for: indexPath) as! CellProtocol
        cell.set(viewModel: block.cellViewModel)
        return cell as! UITableViewCell
    }
    static func register(identifiers: [String], for tableView: UITableView) {
        for identifier in identifiers {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
}
