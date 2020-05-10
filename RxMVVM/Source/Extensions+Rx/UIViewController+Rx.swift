//
//  UIViewController+Rx.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    
    var willAppear: ControlEvent<Void> {
        let source = base.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map({ _ in })
        return ControlEvent(events: source)
    }
    var didAppear: ControlEvent<Void> {
        let source = base.rx.methodInvoked(#selector(UIViewController.viewDidAppear(_:))).map({ _ in })
        return ControlEvent(events: source)
    }
    var willDisappear: ControlEvent<Void> {
        let source = base.rx.methodInvoked(#selector(UIViewController.viewWillDisappear(_:))).map({ _ in })
        return ControlEvent(events: source)
    }
    var didDisappear: ControlEvent<Void> {
        let source = base.rx.methodInvoked(#selector(UIViewController.viewDidDisappear(_:))).map({ _ in })
        return ControlEvent(events: source)
    }
    
    var navigation: Binder<NavigationRouteType> {
        return Binder(self.base, binding: { _, route in
            Navigator.navigate(route: route)
        })
    }
}
