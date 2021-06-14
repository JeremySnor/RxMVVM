//
//  NavigationAction.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public class NavigationAction {
    public let destinationController: UIViewController?
    public let navigationType: NavigationType
    public let animated: Bool
    
    init(destinationController: UIViewController?, animated: Bool = true, navigationType: NavigationType) {
        self.destinationController = destinationController
        self.animated = animated
        self.navigationType = navigationType
    }
    
    public static func create<VC: UIViewController>(navigationType: NavigationType,
                                                    animated: Bool = true,
                                                    _ controllerInstantiation: (() -> VC?)? = nil) -> NavigationAction {
        return NavigationAction(destinationController: controllerInstantiation?(),
                                animated: animated,
                                navigationType: navigationType)
    }
}

public extension NavigationAction {
    
    static func dismiss(animated: Bool = true) -> NavigationAction {
        return self.create(navigationType: .dismiss,
                           animated: animated)
    }
    
    static func pop(animated: Bool = true) -> NavigationAction {
        return self.create(navigationType: .pop,
                           animated: animated)
    }
    
    static func pop(count: Int, animated: Bool = true) -> NavigationAction {
        return self.create(navigationType: .popCount(count),
                           animated: animated)
    }
    
    static func popToRoot(animated: Bool = true) -> NavigationAction {
        return self.create(navigationType: .popToRoot,
                           animated: animated)
    }
    
    static func changeTab(index: Int, animated: Bool = true) -> NavigationAction {
        return self.create(navigationType: .changeTab(index),
                           animated: animated)
    }
    
}
