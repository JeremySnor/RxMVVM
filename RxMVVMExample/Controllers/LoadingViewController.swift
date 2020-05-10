//
//  LoadingViewController.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit
import RxMVVM

class LoadingViewController: ViewController<LoadingViewModel> {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingContentLabel: UILabel!
    
    override func bind(viewModel: ViewController<LoadingViewModel>.ViewModel) {
        
        viewModel.contentText.bind(to: loadingContentLabel.rx.text).disposed(by: disposeBag)
        
        rx.didAppear.bind(to: viewModel.controllerDidAppear).disposed(by: disposeBag)
        rx.didDisappear.bind(to: viewModel.controllerDidDisappear).disposed(by: disposeBag)
        rx.willAppear.bind(to: viewModel.controllerWillAppear).disposed(by: disposeBag)
        rx.willDisappear.bind(to: viewModel.controllerWillDisappear).disposed(by: disposeBag)
        
        viewModel.isLoading.debug("Loading").bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    deinit {
        print("LoadingViewController", "deinited")
    }
}
