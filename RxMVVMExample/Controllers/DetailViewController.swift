//
//  DetailViewController.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit
import RxMVVM

class DetailViewController: ViewController<DetailViewModel> {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.rx.tap.map({ NavigationRoutes.goBack }).debug("Navigation")
            .bind(to: rx.navigation).disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewController<DetailViewModel>.ViewModel) {
        
        rx.didAppear.bind(to: viewModel.controllerDidAppear).disposed(by: disposeBag)
        rx.didDisappear.bind(to: viewModel.controllerDidDisappear).disposed(by: disposeBag)
        rx.willAppear.bind(to: viewModel.controllerWillAppear).disposed(by: disposeBag)
        rx.willDisappear.bind(to: viewModel.controllerWillDisappear).disposed(by: disposeBag)
        
        viewModel.detail.bind(to: detailLabel.rx.text).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    deinit {
        print("DetailViewController", "deinited")
    }

}
