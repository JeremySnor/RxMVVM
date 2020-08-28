//
//  NavigationAppDelegate.swift
//  RxMVVM
//
//  Created by Artem Eremeev on 28.08.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public protocol NavigationAppDelegate: UIApplicationDelegate {
    
    var navigationWindow: UIWindow { get }
    
}
