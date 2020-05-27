//
//  NavigationType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation

public enum NavigationType {
    case undefined
    
    case root 
    
    case modal 
    case dismiss
    
    case push
    case pushAndReplace
    
    case pop
    case popCount(Int)
    case popToRoot
    
    case changeTab(Int)
}
