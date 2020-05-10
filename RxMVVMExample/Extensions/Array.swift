//
//  Array.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation

extension Array {
    
    func appending(_ newElement: Element) -> Self {
        var array = self
        array.append(newElement)
        return array
    }
    func appending<S: Sequence>(contentsOf sequence: S) -> Self where S.Element == Self.Element {
        var array = self
        array.append(contentsOf: sequence)
        return array
    }
}
