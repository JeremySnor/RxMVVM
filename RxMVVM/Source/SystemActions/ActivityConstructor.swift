//
//  ActivityConstructor.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 14.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public class ActivityConstructor: SystemActionConstructorType {
    
    private let activityController: UIActivityViewController
    
    public init(using items: [Any]) {
        activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    public func show() {
        present(controller: activityController)
    }
    
}
