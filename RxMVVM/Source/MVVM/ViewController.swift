//
//  ViewController.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

open class ViewController<VM: ViewModelProtocol>: UIViewController, ViewProtocol {
    
    public let disposeBag = DisposeBag()
    
    public typealias ViewModel = VM
    public var viewModel: ViewModel!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: self.viewModel)
    }
    
    open func bind(viewModel: ViewModel) {
        
        viewModel.subscribeIfNeeded()
    }

}


