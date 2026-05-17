//
//  BehaviorRelay+Ext.swift
//  CXMerchant
//
//  Created by zain guo on 2020/9/8.
//  Copyright © 2020 zain guo. All rights reserved.
//

import Foundation
import RxCocoa

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func append(_ subElement: Element.Element) {
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }
    func insert(_ subElement: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(subElement, at: index)
        accept(newValue)
    }
    func append(contentsOf: [Element.Element]) {
        var newValue = value
        newValue.append(contentsOf: contentsOf)
        accept(newValue)
    }
    func replace(_ element: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        newValue.insert(element, at: index)
        accept(newValue)
    }
    func insert(contentsOf newSubelements: Element, at index: Element.Index) {
        var newValue = value
        newValue.insert(contentsOf: newSubelements, at: index)
        accept(newValue)
    }
    func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
    
    func removeAll() {
        var newValue = value
        newValue.removeAll()
        accept(newValue)
    }
}
