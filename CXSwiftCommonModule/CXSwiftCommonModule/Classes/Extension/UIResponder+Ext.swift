//
//  UIResponder+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit


public extension UIResponder {
    var parentController: UIViewController? {
        return next as? UIViewController ?? next?.parentController
    }
}
