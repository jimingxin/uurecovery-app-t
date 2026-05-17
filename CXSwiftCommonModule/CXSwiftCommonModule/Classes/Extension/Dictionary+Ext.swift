//
//  Dictionary+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/23.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation

/// 两个字典相加
/// - Parameters:
///   - left: left
///   - right: right
/// - Returns: 字典
public func += <Key, Value>(left: [Key: Value], right: [Key: Value]) -> [Key: Value] {
    var result: [Key: Value] = left
    for (key, value) in right {
        result[key] = value
    }
    return result
}


public extension Dictionary {
    
    /// 删除所有
    mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
    
    /// 转JSON字符串
    /// - Returns: 字符串
    func converToJSONString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0)) else { return "" }
        guard let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return ""
        }
        return jsonStr as String
        
    }
   static func converJSONStringToDic(json: String) -> [String: Any]? {
        if let data = json.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
