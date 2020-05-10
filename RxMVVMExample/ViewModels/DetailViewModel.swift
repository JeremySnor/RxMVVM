//
//  DetailViewModel.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import RxMVVM

class DetailViewModel: ViewModel {
    
    let detail: Observable<String>
    
    let controllerWillAppear = PublishSubject<Void>()
    let controllerDidAppear = PublishSubject<Void>()
    let controllerWillDisappear = PublishSubject<Void>()
    let controllerDidDisappear = PublishSubject<Void>()
    
    init(detail: String) {
        self.detail = .just(detail)
    }
    
    override func subscribe() {
        
        controllerWillAppear.debug("DetailViewController WillAppear", trimOutput: true).subscribe().disposed(by: disposeBag)
        controllerDidAppear.debug("DetailViewController DidAppear", trimOutput: true).subscribe().disposed(by: disposeBag)
        controllerWillDisappear.debug("DetailViewController WillDisappear", trimOutput: true).subscribe().disposed(by: disposeBag)
        controllerDidDisappear.debug("DetailViewController DidDisappear", trimOutput: true).subscribe().disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    deinit {
        print("DetailViewModel", "deinited")
    }
    
}
