//
//  AlertConstructor.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 14.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class AlertConstructor: SystemActionConstructorType {
    
    private let alertController: UIAlertController
    private let selectedActionKey = BehaviorRelay<String?>(value: nil)
    
    public init(title: String! = nil, message: String! = nil, style: UIAlertController.Style = .alert) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        self.alertController.constructor = self
    }
    
    deinit {
        print("CLNAlertConstructor released")
    }
    
    public func addAction(title: String, style: UIAlertAction.Style, actionKey: String) -> AlertConstructor {
        alertController.addAction(AlertAction(title: title, style: style, actionKey: actionKey, handler: { [weak self] action in
            if let action = action as? AlertAction {
                self?.selectedActionKey.accept(action.actionKey)
                self?.alertController.constructor = nil
            }
        }))
        return self
    }
    public func addTextField(configurationHandler: ((UITextField) -> Void)?) -> AlertConstructor {
        self.alertController.addTextField(configurationHandler: configurationHandler)
        return self
    }
    
    public func result() -> Single<String> {
        present(controller: alertController)
        return selectedActionKey.skipWhile({ $0 == nil }).map({ $0! }).take(1).asSingle()
    }
    
    public func show() {
        present(controller: alertController)
    }
    
}

fileprivate class AlertAction: UIAlertAction {
    
    private(set) var actionKey: String = ""
    
    convenience init(title: String, style: UIAlertAction.Style, actionKey: String, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, style: style, handler: handler)
        self.actionKey = actionKey
    }
    
}

fileprivate struct UIAlertAssociatedKeys {
    static var constructor: UInt8 = 0
}

fileprivate extension UIAlertController {
    var constructor: AlertConstructor! {
        get { return objc_getAssociatedObject(self, &UIAlertAssociatedKeys.constructor) as? AlertConstructor }
        set { objc_setAssociatedObject(self, &UIAlertAssociatedKeys.constructor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
