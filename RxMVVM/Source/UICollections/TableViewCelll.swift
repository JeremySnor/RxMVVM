//
//  TableViewCelll.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

open class TableViewCell<VM: ViewModelProtocol>: UITableViewCell, ViewProtocol, CellProtocol {
    public typealias ViewModel = VM
    
    public let disposeBag = DisposeBag()
    public private(set) var reusableDisposeBag = DisposeBag()
    
    public func set(viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? VM else {
            fatalError("Не удается преобразовать ViewModelProtocol в \(String(describing: ViewModel.self))")
        }
        bind(viewModel: viewModel)
    }
    
    open func bind(viewModel: VM) {
        
        viewModel.subscribeIfNeeded()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        reusableDisposeBag = DisposeBag()
    }
}
