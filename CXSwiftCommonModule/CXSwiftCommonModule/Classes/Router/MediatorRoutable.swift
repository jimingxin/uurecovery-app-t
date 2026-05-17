//
//  MediatorRoutable.swift
//  Demo
//
//  Created by zain guo on 2020/9/15.
//  Copyright © 2020 zain guo. All rights reserved.
//

import UIKit


public protocol MediatorRoutable where Self: RouterTargetType {
    init?(url: URLConvertible)
}

protocol SwiftyMediatorRouterStoreType {
    
    var routeTargets: [MediatorRoutable.Type] { get set }
    var replacePatterns: [String: URLConvertible] { get set }
}
protocol SwiftyMediatorRoutable where Self: SwiftyMediatorRouterStoreType {
    
    func register(_ targetType: MediatorRoutable.Type)
    func replace(url: URLConvertible, with replacer: URLConvertible)
    func targetType(of url: URLConvertible) -> RouterTargetType?
    func viewController(of url: URLConvertible) -> UIViewController?
}
