//
//  DocumentInteractionConstructor.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 14.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public class DocumentInteractionConstructor: NSObject, SystemActionConstructorType, UIDocumentInteractionControllerDelegate {
    
    private let documentInteractionController: UIDocumentInteractionController
    
    public convenience init(urlString: String) {
        self.init(url: URL(string: urlString)!)
    }
    
    public init(url: URL) {
        documentInteractionController = UIDocumentInteractionController(url: url)

        super.init()
        
        documentInteractionController.delegate = self
    }
    
    public func show() {
        documentInteractionController.presentPreview(animated: true)
    }
    
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return visibleController
    }
    
}
