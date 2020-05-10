//
//  StartViewModel.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import RxMVVM

class StartViewModel: ViewModel {
    
    let pushHello = PublishSubject<Void>()
    let pushWorld = PublishSubject<Void>()
    let pushHelloWorld = PublishSubject<Void>()
    
    let controllerWillAppear = PublishSubject<Void>()
    let controllerDidAppear = PublishSubject<Void>()
    let controllerWillDisappear = PublishSubject<Void>()
    let controllerDidDisappear = PublishSubject<Void>()
    
    override func subscribe() {
        
        pushHello.map({ NavigationRoutes.detailWithText(text: "HELLO") }).debug("Navigation")
            .bind(to: navigation).disposed(by: disposeBag)
        pushWorld.map({ NavigationRoutes.detailWithText(text: "WORLD") }).debug("Navigation")
            .bind(to: navigation).disposed(by: disposeBag)
        pushHelloWorld.map({ NavigationRoutes.detailWithText(text: "HELLO WORLD") }).debug("Navigation")
            .bind(to: navigation).disposed(by: disposeBag)
        
        controllerWillAppear.debug("StartViewController WillAppear").subscribe().disposed(by: disposeBag)
        controllerDidAppear.debug("StartViewController DidAppear").subscribe().disposed(by: disposeBag)
        controllerWillDisappear.debug("StartViewController WillDisappear").subscribe().disposed(by: disposeBag)
        controllerDidDisappear.debug("StartViewController DidDisappear").subscribe().disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    deinit {
        print("StartViewModel", "deinited")
    }
    
}
