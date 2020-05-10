//
//  StartViewController.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit
import RxSwift
import RxMVVM

class StartViewController: ViewController<StartViewModel> {

    @IBOutlet weak var pushHelloButton: UIButton!
    @IBOutlet weak var pushWorldButton: UIButton!
    @IBOutlet weak var pushHelloWorldButton: UIButton!
    
    @IBOutlet weak var openLoadingButton: UIButton!
    @IBOutlet weak var openTablesButton: UIButton!
    
    override func bind(viewModel: ViewController<StartViewModel>.ViewModel) {
        
        rx.didAppear.bind(to: viewModel.controllerDidAppear).disposed(by: disposeBag)
        rx.didDisappear.bind(to: viewModel.controllerDidDisappear).disposed(by: disposeBag)
        rx.willAppear.bind(to: viewModel.controllerWillAppear).disposed(by: disposeBag)
        rx.willDisappear.bind(to: viewModel.controllerWillDisappear).disposed(by: disposeBag)
        
        pushHelloButton.rx.tap.bind(to: viewModel.pushHello).disposed(by: disposeBag)
        pushWorldButton.rx.tap.bind(to: viewModel.pushWorld).disposed(by: disposeBag)
        pushHelloWorldButton.rx.tap.bind(to: viewModel.pushHelloWorld).disposed(by: disposeBag)
        
        openLoadingButton.rx.tap.map({ NavigationRoutes.loading }).bind(to: rx.navigation).disposed(by: disposeBag)
        openTablesButton.rx.tap.map({ NavigationRoutes.marks }).bind(to: rx.navigation).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }

    deinit {
        print("StartViewController", "deinited")
    }
    
}
