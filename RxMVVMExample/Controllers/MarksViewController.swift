//
//  MarksViewController.swift
//  RxMVVMExample
//
//  Created by Artem Eremeev on 10.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit
import RxMVVM
import RxDataSources

class MarksViewController: ViewController<MarksViewModel> {

    @IBOutlet weak var marksTableView: UITableView!
    @IBOutlet weak var noButton: UIBarButtonItem!
    @IBOutlet weak var yesButton: UIBarButtonItem!
    
    typealias MarksSection = SectionModel<String, MarksBlock>
    let marksDataSource: RxTableViewSectionedReloadDataSource<MarksSection> = TableViewConnector.reloadTableViewDataSource(MarksBlock.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewConnector.register(MarksBlock.self, for: marksTableView)
    }
    
    override func bind(viewModel: ViewController<MarksViewModel>.ViewModel) {
        
        viewModel.marksSections.bind(to: marksTableView.rx.items(dataSource: marksDataSource)).disposed(by: disposeBag)
        
        yesButton.rx.tap.bind(to: viewModel.addYesMark).disposed(by: disposeBag)
        noButton.rx.tap.bind(to: viewModel.addNoMark).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }

    deinit {
        print("MarksViewController", "deinited")
    }
    
}
