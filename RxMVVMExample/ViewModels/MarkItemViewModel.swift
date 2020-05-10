//
//  MarkItemViewModel.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class MarkItemViewModel: ViewModel {
    
    private let date = Date()
    lazy var dateString = Observable.just(String(describing: date))
    
}
