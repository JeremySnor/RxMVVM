//
//  NavigationRoutes.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxMVVM

enum NavigationRoutes: NavigationRouteType {
    
    case goBack
    case closeModal
    
    case start
    case detailWithText(text: String)
    case loading
    case marks
    
    var navigationAction: NavigationAction {
        switch self {
        case .goBack:
            return NavigationAction.create(navigationType: .pop)
        case .closeModal:
            return NavigationAction.create(navigationType: .dismiss)
            
        case .start:
            return NavigationAction.create(navigationType: .root) {
                return UINavigationController(rootViewController: self.instantiateController(StartViewController.self, storyboardName: "Main", viewModel: StartViewModel()))
            }
        case let .detailWithText(text):
            return NavigationAction.create(navigationType: .push, animated: false) {
                return self.instantiateController(DetailViewController.self, storyboardName: "Main", viewModel: DetailViewModel(detail: text))
            }
        case .loading:
            return NavigationAction.create(navigationType: .push) {
                return self.instantiateController(LoadingViewController.self, storyboardName: "Main", viewModel: LoadingViewModel())
            }
            
        case .marks:
            return NavigationAction.create(navigationType: .push) {
                return self.instantiateController(MarksViewController.self, storyboardName: "Main", viewModel: MarksViewModel())
            }
        }
    }
}
