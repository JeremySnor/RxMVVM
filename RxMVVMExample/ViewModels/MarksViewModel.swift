//
//  MarksViewModel.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxDataSources
import RxSwift

class MarksViewModel: ViewModel {
    
    private let marksBlocks = BehaviorSubject<[MarksBlock]>(value: [])
    lazy var marksSections = marksBlocks.map({ [SectionModel(model: "", items: $0)] })
    
    let addYesMark = PublishSubject<Void>()
    let addNoMark = PublishSubject<Void>()
    
    override func subscribe() {
        addYesMark.withLatestFrom(marksBlocks)
            .map({ $0.appending(.yes(MarkItemViewModel())) })
            .bind(to: marksBlocks).disposed(by: disposeBag)
        
        addNoMark.withLatestFrom(marksBlocks)
            .map({ $0.appending(.no(MarkItemViewModel())) })
            .bind(to: marksBlocks).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    deinit {
        print("MarksViewModel", "deinited")
    }
    
}
