//
//  CellBlockType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation

public protocol CellBlockProtocol {
    var cellIdentifier: String { get }
    var cellViewModel: ViewModelProtocol { get }
    
    static var allCellIdentifier: [String] { get }
}
