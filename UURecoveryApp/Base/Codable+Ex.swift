//
//  Codable+Ex.swift
//  CXMerchant
//
//  Created by 嵇明新 on 2021/7/14.
//  Copyright © 2021 jimingxin. All rights reserved.
//

import Foundation

protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
struct Default<T: DefaultValue> {
    var wrappedValue: T.Value
}

extension Default: Encodable {
}

extension Default: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        //判断 key 缺失的情况，提供默认值
        (try decodeIfPresent(type, forKey: key)) ?? Default(wrappedValue: T.defaultValue)
    }
}


extension Int: DefaultValue {
    static var defaultValue:Int = 0
}

extension String: DefaultValue {
    static var defaultValue = ""
}

extension Bool: DefaultValue {
    static var defaultValue = false
}

extension Double: DefaultValue {
    static var defaultValue:Double = 0
}

extension Float: DefaultValue {
    static var defaultValue = 0
}
