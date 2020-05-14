//
//  SafariConstructor.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 14.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import SafariServices

public class SafariConstructor: SystemActionConstructorType {
    
    private let safariController: SFSafariViewController
    
    public convenience init(urlString: String) {
        self.init(url: URL(string: urlString)!)
    }
    
    public init(url: URL) {
        safariController = SFSafariViewController(url: url)
    }
    
    public func show() {
        present(controller: safariController)
    }
    
}
