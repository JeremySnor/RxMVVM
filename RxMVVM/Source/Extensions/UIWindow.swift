//
//  UIWindow.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public extension UIWindow {

    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.visibleController(from: rootViewController)
        }
        return nil
    }

    class func visibleController(from controller: UIViewController) -> UIViewController {

        if let navigationController = controller as? UINavigationController {
            
            return UIWindow.visibleController(from: navigationController.visibleViewController!)

        } else if let tabBarController = controller as? UITabBarController {
            
            return UIWindow.visibleController(from: tabBarController.selectedViewController!)

        } else {

            if let presentedViewController = controller.presentedViewController {

                return UIWindow.visibleController(from: presentedViewController)

            } else if !controller.children.isEmpty {
                
                if let tabBarController = controller.children.compactMap({ $0 as? UITabBarController }).first {
                    return UIWindow.visibleController(from: tabBarController.selectedViewController!)
                }
                if let navigationController = controller.children.compactMap({ $0 as? UINavigationController }).first {
                    return UIWindow.visibleController(from: navigationController.visibleViewController!)
                }
                
            }
            
            return controller
            
        }
    }
}
