//
//  Equatable+Ext.swift
//  CXSwiftCommonModule
//
//  Created by jimingxin on 2020/11/13.
//

import Foundation

public extension Equatable where Self == Int {
    static var isNull: Self {
        return -999
    }
}

public extension Equatable where Self == Double {
   static var isNull: Self {
        return -999
    }
}
