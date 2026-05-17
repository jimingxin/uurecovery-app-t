//
//  Array+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/23.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation


public func == <T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

public extension Array {
    
    /// 下标防止数组越界
    subscript (safe index: Index) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    /// 根据索引获取数组元素
    func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    /// 替换指定索引value
    mutating func set(at index: Int, value: Element) {
        guard index >= 0 && index < count else { return }
        self[index] = value
    }
    /// 转NSMutableArray
    /// - Returns: NSMutableArray
    func toNSMutableArray() -> NSMutableArray {
        let array: NSMutableArray = []
        for item in self {
            array.add(item)
        }
        return array
    }
}

public extension Array where Element: Hashable {
    
    
    private func removingDuplicates() -> [Element] {
        var adder = [Element: Bool]()
        return filter {
            adder.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
}




