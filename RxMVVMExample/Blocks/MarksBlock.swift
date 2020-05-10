//
//  MarksBlock.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxMVVM

enum MarksBlock: CellBlockProtocol {
    
    case yes(MarkItemViewModel)
    case no(MarkItemViewModel)
    
    var cellIdentifier: String {
        switch self {
        case .yes: return YesMarkTableViewCell.cellIdentifier
        case .no: return NoMarkTableViewCell.cellIdentifier
        }
    }
    
    var cellViewModel: ViewModelProtocol {
        switch self {
        case let .yes(viewModel),
             let .no(viewModel):
            return viewModel
        }
    }
    
    static var allCellIdentifier: [String] = [
        YesMarkTableViewCell.cellIdentifier,
        NoMarkTableViewCell.cellIdentifier
    ]
    
}
