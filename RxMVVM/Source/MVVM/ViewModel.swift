//
//  ViewModel.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

open class ViewModel: NSObject, ViewModelProtocol {
    
    public let disposeBag = DisposeBag()
    
    private var needSubscribe = true
    
    public lazy var isLoading = ControlProperty(values: _isLoading, valueSink: _isLoading)
    private let _isLoading = BehaviorSubject<Bool>(value: false)
    
    public lazy var navigation: Binder<NavigationRouteType> = Binder(self, binding: { _, route in
        Navigator.navigate(route: route)
    })

    public func subscribeIfNeeded() {
        guard needSubscribe else {
            return
        }
        needSubscribe = false
        subscribe()
    }
    
    /// Do not call directly!!!
    open func subscribe() {
        
    }

}
