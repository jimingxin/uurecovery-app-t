//
//  NavigationBarView+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

extension UIViewController: CXNameSpace { }

private struct AssociatedKeys {
    static var navigationBarKey: Void?
}

public extension CXKit where Base: UIViewController {
    
    /// 导航栏
    var navigationBar: NavigationBarView? {
        get {
            var bar = objc_getAssociatedObject(base, &AssociatedKeys.navigationBarKey) as? NavigationBarView
            if bar == nil {
                bar = NavigationBarView(frame: .zero)
                bar?.backgroundColor = .white
                base.view.addSubview(bar!)
                objc_setAssociatedObject(base, &AssociatedKeys.navigationBarKey, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return bar
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.navigationBarKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

