//
//  Navigator.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public class Navigator {
    
    private(set) static var window: UIWindow?
    
    private static var visibleController: UIViewController! {
        guard let visibleController = window?.visibleViewController() else {
            return nil
        }
        return visibleController
    }
    
    public static func set(window: inout UIWindow?, route: NavigationRouteType) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        self.window = window
        root(route.navigationAction.destinationController!)
    }
    
    public static func navigate(route: NavigationRouteType) {
        DispatchQueue.main.async {
            let navigationAction = route.navigationAction
            switch navigationAction.navigationType {
            case .undefined: break
            case .root: root(navigationAction.destinationController!)
                
            case .modal: modal(navigationAction.destinationController!)
            case .dismiss: dismiss()
                
            case .push: push(navigationAction.destinationController!)
            case .pushAndReplace: pushAndReplace(navigationAction.destinationController!)
                
            case .pop: pop()
            case let .popCount(count): pop(count: count)
            case .popToRoot: popToRoot()
                
            case let .changeTab(index): changeTab(tabIndex: index)
            }
        }
    }
    
    private static func root(_ controller: UIViewController) {
        window?.rootViewController = controller
    }
    
    private static func modal(_ controller: UIViewController) {
        (visibleController?.navigationController ?? visibleController)?.present(controller, animated: true)
    }
    
    private static func push(_ controller: UIViewController) {
        visibleController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    private static func pushAndReplace(_ controller: UIViewController) {
        if var controllers = visibleController?.navigationController?.viewControllers {
            controllers.removeLast()
            controllers.append(controller)
            visibleController?.navigationController?.setViewControllers(controllers, animated: true)
        }
    }
    
    private static func pop() {
        visibleController?.navigationController?.popViewController(animated: true)
    }
    private static func pop(count: Int) {
        if let viewControllers = visibleController?.navigationController?.viewControllers {
            let targetIndex = max(0, viewControllers.count - count - 1)
            visibleController?.navigationController?.popToViewController(viewControllers[targetIndex], animated: true)
        }
    }
    private static func popToRoot() {
        visibleController?.navigationController?.popToRootViewController(animated: true)
    }
    
    private static func dismiss() {
        visibleController?.dismiss(animated: true)
    }
    private static func changeTab(tabIndex: Int) {
        visibleController?.tabBarController?.selectedIndex = tabIndex
    }
    
}
