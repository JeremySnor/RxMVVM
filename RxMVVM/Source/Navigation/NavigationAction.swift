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
    
    init(destinationController: UIViewController?, navigationType: NavigationType) {
        self.destinationController = destinationController
        self.navigationType = navigationType
    }
    
    public static func create<VC: UIViewController>(navigationType: NavigationType,
                                                    _ controllerInstantiation: (() -> VC?)? = nil) -> NavigationAction {
        return NavigationAction(destinationController: controllerInstantiation?(),
                                navigationType: navigationType)
    }
}
