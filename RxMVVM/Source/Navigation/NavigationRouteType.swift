//
//  NavigationRouteType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public protocol NavigationRouteType {
    var navigationAction: NavigationAction { get }
}

public extension NavigationRouteType {
    func instantiateController<VC: UIViewController>(_ controllerIndentifier: String, storyboardName: String) -> VC {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: controllerIndentifier) as! VC
        return controller
    }
    func instantiateControllerWithViewModel<VM: ViewModel, VC: ViewController<VM>>(controllerIndentifier: String, storyboardName: String, viewModel: VM) -> VC {
        let controller: VC = instantiateController(controllerIndentifier, storyboardName: storyboardName)
        controller.viewModel = viewModel
        return controller
    }
    func instantiateController<VM: ViewModel, VC: ViewController<VM>>(_ controller: VC.Type, storyboardName: String, viewModel: VM) -> VC {
        let controller: VC = instantiateController(controller.controllerIdentifier, storyboardName: storyboardName)
        controller.viewModel = viewModel
        return controller
    }
}
