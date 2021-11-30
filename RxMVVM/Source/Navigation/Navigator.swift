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
    
    public typealias Completion = () -> Void
    
    private(set) static var window: UIWindow?
    
    private static var visibleController: UIViewController! {
        guard let visibleController = self.window?.visibleViewController() else {
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
    
    public static func navigateChainOf(routes: NavigationRouteType..., completion: Completion? = nil) {
        Self.navigateChainOf(routes: routes, completion: completion)
    }
    
    public static func navigateChainOf(routes: [NavigationRouteType], completion: Completion? = nil) {
        var remainingRoutes = routes
        
        guard !remainingRoutes.isEmpty else {
            completion?()
            return
        }
        
        let nextRoute = remainingRoutes.removeFirst()
        Self.navigate(route: nextRoute, completion: {
            Self.navigateChainOf(routes: remainingRoutes, completion: completion)
        })
    }
    
    public static func navigate(route: NavigationRouteType, completion: Completion? = nil) {
        DispatchQueue.main.async {
            let navigationAction = route.navigationAction
            
            switch navigationAction.navigationType {
            case .undefined:
                break
                
            case .root:
                self.root(navigationAction.destinationController!)
                completion?()
                
            case .modal:
                if navigationAction.animated {
                    Self.handleAnimatedCompletion(of: {
                        Self.modal(navigationAction.destinationController!, animated: true)
                    }, completion: {
                        completion?()
                    })
                } else {
                    Self.modal(navigationAction.destinationController!, animated: false)
                    completion?()
                }
                
            case .dismiss:
                self.dismiss(animated: navigationAction.animated,
                             completion: completion)
                
            case .push:
                if navigationAction.animated {
                    Self.handleAnimatedCompletion(of: {
                        Self.push(navigationAction.destinationController!, animated: true)
                    }, completion: {
                        completion?()
                    })
                } else {
                    Self.push(navigationAction.destinationController!, animated: false)
                    completion?()
                }
                
            case .pushAndReplace:
                if navigationAction.animated {
                    Self.handleAnimatedCompletion(of: {
                        Self.pushAndReplace(navigationAction.destinationController!, animated: true)
                    }, completion: {
                        completion?()
                    })
                } else {
                    Self.pushAndReplace(navigationAction.destinationController!, animated: false)
                    completion?()
                }
                
            case .pop:
                if navigationAction.animated {
                    Self.handleAnimatedCompletion(of: {
                        Self.pop(animated: true)
                    }, completion: {
                        completion?()
                    })
                } else {
                    Self.pop(animated: false)
                    completion?()
                }
                
            case let .popCount(count):
                if navigationAction.animated {
                    Self.handleAnimatedCompletion(of: {
                        Self.pop(count: count, animated: true)
                    }, completion: {
                        completion?()
                    })
                } else {
                    self.pop(count: count, animated: false)
                    completion?()
                }
                
            case .popToRoot:
                if navigationAction.animated {
                    Self.handleAnimatedCompletion(of: {
                        Self.popToRoot(animated: true)
                    }, completion: {
                        completion?()
                    })
                } else {
                    Self.popToRoot(animated: false)
                    completion?()
                }
                
            case let .changeTab(index):
                self.changeTab(tabIndex: index)
                completion?()
            }
        }
    }
    
}

fileprivate extension Navigator {
        
    static func handleAnimatedCompletion(of navigation: @escaping () -> Void,
                                         completion: @escaping Completion) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        navigation()
        CATransaction.commit()
    }
    
    static func root(_ controller: UIViewController) {
        self.window?.rootViewController = controller
    }
    
    static func modal(_ controller: UIViewController, animated: Bool = true, completion: Completion? = nil) {
        (self.visibleController?.navigationController ?? self.visibleController)?.present(controller,
                                                                                          animated: animated,
                                                                                          completion: completion)
    }
    
    static func push(_ controller: UIViewController, animated: Bool = true) {
        if let searchController = self.visibleController as? UISearchController {
            searchController.presentingViewController?.navigationController?.pushViewController(controller, animated: animated)
        } else {
            self.visibleController?.navigationController?.pushViewController(controller, animated: animated)
        }
    }
    
    static func pushAndReplace(_ controller: UIViewController, animated: Bool = true) {
        if var controllers = self.visibleController?.navigationController?.viewControllers {
            controllers.removeLast()
            controllers.append(controller)
            self.visibleController?.navigationController?.setViewControllers(controllers, animated: animated)
        }
    }
    
}

public extension Navigator {
    
    static func pop(animated: Bool = true) {
        self.visibleController?.navigationController?.popViewController(animated: animated)
    }
    
    static func pop(count: Int, animated: Bool = true) {
        if let viewControllers = self.visibleController?.navigationController?.viewControllers {
            let targetIndex = max(0, viewControllers.count - count - 1)
            self.visibleController?.navigationController?.popToViewController(viewControllers[targetIndex], animated: animated)
        }
    }
    
    static func popToRoot(animated: Bool = true) {
        self.visibleController?.navigationController?.popToRootViewController(animated: animated)
    }
    
    static func dismiss(animated: Bool = true, completion: Completion? = nil) {
        self.visibleController?.dismiss(animated: animated, completion: completion)
    }
    
    static func changeTab(tabIndex: Int) {
        self.visibleController?.tabBarController?.selectedIndex = tabIndex
    }
    
}
