//
//  ViewType.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 09.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewProtocol where Self.ViewModel: ViewModelProtocol {
    associatedtype ViewModel
    func bind(viewModel: ViewModel)
}

public extension UIViewController {
    static var controllerIdentifier: String {
        return String(describing: self)
    }
}

public extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

public extension UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
