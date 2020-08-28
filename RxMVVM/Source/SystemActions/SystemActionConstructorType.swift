//
//  SystemActionConstructorType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 14.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public protocol SystemActionConstructorType { }

public extension SystemActionConstructorType {
    
    var visibleController: UIViewController! {
        guard let delegate = UIApplication.shared.delegate as? NavigationAppDelegate else {
            return nil
        }
        guard let visibleController = delegate.navigationWindow.visibleViewController() else {
            return nil
        }
        return visibleController
    }
    
    func present(controller: UIViewController, completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            self.visibleController?.present(controller, animated: true, completion: completion)
        }
    }
}
