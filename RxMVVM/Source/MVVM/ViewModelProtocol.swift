//
//  ViewModelType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewModelProtocol {
    
    func subscribeIfNeeded()
    func subscribe()
    
}
