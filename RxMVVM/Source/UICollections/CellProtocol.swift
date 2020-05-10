//
//  CellType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation

public protocol CellProtocol {
    static var cellIdentifier: String { get }
    func set(viewModel: ViewModelProtocol)
}
