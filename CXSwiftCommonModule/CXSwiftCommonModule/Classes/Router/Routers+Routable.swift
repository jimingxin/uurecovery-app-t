//
//  SwiftRouter+Routable.swift
//  SwiftRouter
//
//  Created by zain guo on 2020/9/12.
//  Copyright © 2020 zain guo. All rights reserved.
//

import UIKit


extension Routers: SwiftyMediatorRouterStoreType {
    private struct AssociatedKeys {
        static var routeTargetsKey = "routeTargetsKey"
        static var replacePatternsKey = "replacePatternsKey"
        static var routerTargetsMapKey = "routerTargetsMapKey"
    }
    public var routeTargets: [MediatorRoutable.Type] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.routeTargetsKey) as? [MediatorRoutable.Type] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.routeTargetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var replacePatterns: [String : URLConvertible] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.replacePatternsKey) as? [String: URLConvertible] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.replacePatternsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    public var routerTargetsMap: [String : RouterTargetType] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.routerTargetsMapKey) as? [String: RouterTargetType] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.routerTargetsMapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
}
extension Routers: SwiftyMediatorRoutable {
    public func register(_ targetType: MediatorRoutable.Type) {
        self.routeTargets.append(targetType)
    }
    
    public func replace(url: URLConvertible, with replacer: URLConvertible) {
        self.replacePatterns[url.pattern] = replacer
    }
    public func targetType(of url: URLConvertible) -> RouterTargetType? {
        
        let url = self.replacePatterns[url.pattern] ?? url
        if let target = routerTargetsMap[url.urlStringValue] {
            return target
        }
//        let start = CFAbsoluteTimeGetCurrent()
        guard let routable = routeTargets.compactMap({ $0.init(url: url) }).first else { return nil }
//        let end = CFAbsoluteTimeGetCurrent()
//        debugPrint("代码执行时长：%f 毫秒", (end - start)*1000)
        guard let target = routable as? RouterTargetType else { return nil }
        
        self.routerTargetsMap[url.urlStringValue] = target
        
        return target
    }
    
    public func viewController(of url: URLConvertible) -> UIViewController? {
        let url = self.replacePatterns[url.pattern] ?? url
        guard let target = self.targetType(of: url) else { return nil }
        return self.viewController(of: target)
    }
}


