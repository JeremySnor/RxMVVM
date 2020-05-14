//
//  MediaPickerConstructor.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 14.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class MediaPickerConstructor: NSObject, SystemActionConstructorType, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public enum Media {
        case image(URL)
        case uiimage(UIImage)
        case video(URL)
    }
    
    private let imagePickerController: UIImagePickerController
    private let selectedMedia = BehaviorRelay<Media?>(value: nil)
    
    private let close = PublishSubject<Void>()
    
    public init(sourceType: UIImagePickerController.SourceType) {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.sourceType = sourceType
        
        super.init()
        
        self.imagePickerController.delegate = self
        self.imagePickerController.constructor = self
    }
    
    deinit {
        print("MediaPickerConstructor released")
    }
    
    public func show() -> Single<Media> {
        present(controller: imagePickerController)
        return selectedMedia.skipWhile({ $0 == nil }).map({ $0! }).asObservable().take(1).asSingle()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if #available(iOS 11, *), let imageURL = info[.imageURL] as? URL {
            selectedMedia.accept(.image(imageURL))
        } else if let image = info[.originalImage] as? UIImage {
            selectedMedia.accept(.uiimage(image))
        } else if let videoURL = info[.mediaURL] as? URL {
            selectedMedia.accept(.video(videoURL))
        }
        
        picker.dismiss(animated: true) {
            picker.constructor = nil
        }
    }
    
}

fileprivate struct UIImagePickerAssociatedKeys {
    static var constructor: UInt8 = 0
}

fileprivate extension UIImagePickerController {
    var constructor: MediaPickerConstructor! {
        get { return objc_getAssociatedObject(self, &UIImagePickerAssociatedKeys.constructor) as? MediaPickerConstructor }
        set { objc_setAssociatedObject(self, &UIImagePickerAssociatedKeys.constructor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
