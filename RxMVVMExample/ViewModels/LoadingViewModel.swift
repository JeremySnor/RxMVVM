//
//  LoadingViewModel.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import RxMVVM

class LoadingViewModel: ViewModel {
    
    lazy var contentText = isLoading.map({ $0 ? "loading..." : "completed" })
    
    let controllerWillAppear = PublishSubject<Void>()
    let controllerDidAppear = PublishSubject<Void>()
    let controllerWillDisappear = PublishSubject<Void>()
    let controllerDidDisappear = PublishSubject<Void>()
    
    override func subscribe() {
        
        controllerWillAppear.debug("LoadingViewController WillAppear", trimOutput: true).subscribe().disposed(by: disposeBag)
        controllerDidAppear.debug("LoadingViewController DidAppear", trimOutput: true).subscribe().disposed(by: disposeBag)
        controllerWillDisappear.debug("LoadingViewController WillDisappear", trimOutput: true).subscribe().disposed(by: disposeBag)
        controllerDidDisappear.debug("LoadingViewController DidDisappear", trimOutput: true).subscribe().disposed(by: disposeBag)
        
        controllerDidAppear.map({ true }).bind(to: isLoading).disposed(by: disposeBag)
        
        controllerDidAppear.delay(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
            .map({ false }).bind(to: isLoading).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    deinit {
        print("LoadingViewModel", "deinited")
    }
    
}
