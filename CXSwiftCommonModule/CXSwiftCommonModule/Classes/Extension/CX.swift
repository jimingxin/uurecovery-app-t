//
//  CX.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/23.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import RxSwift


/// 常量
struct CXConstraint {
    static let disposeBag = DisposeBag()
}

public struct CXKit<Base> {
    public var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol CXNameSpace {
    associatedtype T
    var cx: CXKit<T> { get set }
}

public extension CXNameSpace {
    var cx: CXKit<Self> {
        get {
            return CXKit(self)
        }
        set { }
    }
    static var cx: CXKit<Self>.Type {
        return CXKit<Self>.self
    }
}



