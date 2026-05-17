//
//  UIViewController+TableView.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/17.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var group_tableViewKey: Void?
}

public extension CXKit where Base: UIViewController  {
    
    var group_tableView: UITableView {
        
        get {
            var tabView = objc_getAssociatedObject(base, &AssociatedKeys.group_tableViewKey) as? UITableView
            if tabView == nil {
                tabView = UITableView(frame: base.view.bounds, style: .grouped)
                tabView?.backgroundColor = .hex("f5f5f5")
                tabView?.separatorStyle = .none
                tabView?.keyboardDismissMode = .onDrag
                tabView?.showsVerticalScrollIndicator = false
                tabView?.rowHeight = 50
                tabView?.estimatedRowHeight = 50
                tabView?.sectionHeaderHeight = 10
                tabView?.estimatedSectionHeaderHeight = 10
                tabView?.sectionFooterHeight = 0.01
                tabView?.estimatedSectionFooterHeight = 0
                base.view.addSubview(tabView!)

                objc_setAssociatedObject(base, &AssociatedKeys.group_tableViewKey, tabView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return tabView!
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.group_tableViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    var tableView: UITableView {
        get {
            
            var tabView = objc_getAssociatedObject(base, &AssociatedKeys.group_tableViewKey) as? UITableView
            if tabView == nil {
                tabView = UITableView(frame: base.view.bounds)
                tabView?.backgroundColor = .hex("f5f5f5")
                tabView?.estimatedRowHeight = 50
                tabView?.separatorStyle = .none
                tabView?.keyboardDismissMode = .onDrag
                tabView?.showsVerticalScrollIndicator = false
                tabView?.rowHeight = 50
                tabView?.sectionHeaderHeight = 0
                tabView?.sectionFooterHeight = 0.01
                tabView?.estimatedSectionHeaderHeight = 0
                tabView?.estimatedSectionFooterHeight = 0
                base.view.addSubview(tabView!)
                
                objc_setAssociatedObject(base, &AssociatedKeys.group_tableViewKey, tabView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return tabView!
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.group_tableViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
}


