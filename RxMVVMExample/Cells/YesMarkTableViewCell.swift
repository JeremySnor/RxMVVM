//
//  YesMarkTableViewCell.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit
import RxMVVM

class YesMarkTableViewCell: TableViewCell<MarkItemViewModel> {
    
    override func bind(viewModel: MarkItemViewModel) {
        viewModel.dateString.bind(to: detailTextLabel!.rx.text).disposed(by: reusableDisposeBag)
        super.bind(viewModel: viewModel)
    }
    
}
