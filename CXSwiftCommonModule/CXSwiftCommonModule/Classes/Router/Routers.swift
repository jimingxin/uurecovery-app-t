//
//  Routers.swift
//  Demo
//
//  Created by zain guo on 2020/9/15.
//  Copyright © 2020 zain guo. All rights reserved.
//

import UIKit

public let Router = Routers.router

public class Routers {
    
    static let router = Routers()
    
    public typealias Completion = () -> Void
    
    /// Push
    /// - Parameters:
    ///   - target: target
    ///   - from: 视图控制器
    ///   - animated: 是否需要动画: 默认true
    ///   - completion: 回调
    /// - Returns: 目标视图控制器
    @discardableResult
    
    public func push(_ target: RouterTargetType,
                     from: UINavigationController? = nil,
                     animated: Bool = true,
                     completion: Completion? = nil) -> UIViewController? {
        
        guard let viewController = self.viewController(of: target) else { return nil }
        guard let navigationController = from ?? UIViewController.topMost?.navigationController else { return nil }
        defer {
            if let completion = completion {
                completion()
            }
        }
        if navigationController.children.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        navigationController.pushViewController(viewController, animated: animated)
        return viewController
    }
    
    /// Present
    /// - Parameters:
    ///   - target: target
    ///   - from: 视图控制器
    ///   - wrap: 是否需要导航控制器包裹
    ///   - style: 模态style 默认: fullScreen
    ///   - animated: 是否需要动画: 默认true
    ///   - completion: 回调
    /// - Returns: 目标视图控制器
    @discardableResult
    
    public func present(_ target: RouterTargetType,
                        from: UIViewController? = nil,
                        wrap: UINavigationController.Type? = nil,
                        style: UIModalPresentationStyle = .fullScreen,
                        animated: Bool = true,
                        completion: Completion? = nil) -> UIViewController? {
        
        guard let viewController = self.viewController(of: target) else { return nil }
        guard let fromViewController = from ?? UIViewController.topMost else { return nil }
        let viewControllerToPresent: UIViewController
        if let navigationControllerClass = wrap,
            (viewController is UINavigationController) == false {
            viewControllerToPresent = navigationControllerClass.init(rootViewController: viewController)
        } else {
            viewControllerToPresent = viewController
        }
        if fromViewController.navigationController?.children.count ?? 0 >= 1 {
            viewControllerToPresent.hidesBottomBarWhenPushed = true
            fromViewController.hidesBottomBarWhenPushed = true
        }
        viewControllerToPresent.modalPresentationStyle = style
        fromViewController.present(viewControllerToPresent, animated: animated, completion: completion)
        return viewController
    }
    
    
    /// Dismiss
    /// - Parameters:
    ///   - from: 视图控制器
    ///   - animated: 是否需要动画: 默认true
    ///   - completion: 回调
    public func dismiss(from: UIViewController? = nil,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        
        guard let fromViewController = from ?? UIViewController.topMost else { return }
        fromViewController.dismiss(animated: animated, completion: completion)
    }
    
    
    /// Pop
    /// - Parameters:
    ///   - from: 视图控制器
    ///   - animated: 是否需要动画: 默认true
    public func pop(from: UIViewController? = nil,
                    animated: Bool = true) {
        
        guard let fromViewController = from ?? UIViewController.topMost else { return }
        fromViewController.navigationController?.popViewController(animated: animated)
    }
    
    /// Pop to Root
    /// - Parameters:
    ///   - from: 视图控制器
    ///   - animated: 是否需要动画: 默认true
    public func popToRoot(from: UIViewController? = nil,
                          animated: Bool = true) {
        
        guard let fromViewController = from ?? UIViewController.topMost else { return }
        fromViewController.navigationController?.popToRootViewController(animated: animated)
    }
    
    /// Pop 到指定视图控制器
    /// - Parameters:
    ///   - target: target
    ///   - from: 视图控制器
    ///   - animated: 是否需要动画: 默认true
    public func popToController(_ target: RouterTargetType,
                                from: UIViewController? = nil,
                                animated: Bool = true) {
        
        guard let viewController = self.viewController(of: target) else { return }
        guard let fromViewController = from ?? UIViewController.topMost else { return }
        if let viewControllers = fromViewController.navigationController?.viewControllers {
            for ( _, vc) in viewControllers.enumerated() {
                if vc == viewController {
                    fromViewController.navigationController?.popToViewController(vc, animated: animated)
                    return
                }
            }

        }
    }
    
    /// Pop到指定索引位置
    /// - Parameters:
    ///   - index: 视图控制器索引
    ///   - from: 视图控制器
    ///   - animated: 是否需要动画: 默认true
    public func popToPageIndex(index: Int,
                               from: UIViewController? = nil,
                               animated: Bool = true) {
        
        guard let fromViewController = from ?? UIViewController.topMost else { return }
        
        if var viewControllers = fromViewController.navigationController?.viewControllers, viewControllers.count > index,
            viewControllers.count - 1 > index {
            
            viewControllers.removeSubrange((index + 1)...(viewControllers.count - 1))
            fromViewController.navigationController?.setViewControllers(viewControllers, animated: animated)
        }

    }
    
    /// 设置根视图
    /// - Parameter target: target
    public func rooterController(_ target: RouterTargetType) {
        
        guard let viewController = self.viewController(of: target) else { return }
        UIWindow.key?.rootViewController = viewController

    }
    
    /// 跳转到指定索引位置的Tabbar
    /// - Parameters:
    ///   - index: Tabbar index
    ///   - from: 视图控制器
    ///   - completion: 回调
    /// - Returns: idnex
    @discardableResult
    
    public func selectedTabBar(index: Int,
                               from: UIViewController? = nil,
                               completion: Completion? = nil) -> Int? {
        
        guard let fromViewController = from ?? UIViewController.topMost else { return nil }
        
        defer {
            if let completion = completion {
                completion()
            }
        }
        if let tab = fromViewController as? UITabBarController,
            tab.viewControllers?.count ?? 0 >= index,
            index >= 0 {
            tab.selectedIndex = index
            return index
        }

        if fromViewController.tabBarController?.viewControllers?.count ?? 0 >= index,
            index >= 0 {
            fromViewController.tabBarController?.selectedIndex = index
            if fromViewController.navigationController?.children.count ?? 0 > 0 {
                fromViewController.navigationController?.popToRootViewController(animated: false)
            }
            return index
        }
        return nil
    }
}

extension Routers {
    
    @discardableResult
    
    public func open(_ url: URLConvertible,
                     from: UINavigationController? = nil,
                     animated: Bool = true) -> UIViewController? {
        
        guard let target = self.targetType(of: url) else { return nil }
        
        switch url.path {
        case "/push":
            return self.push(target, from: from, animated: animated, completion: nil)
        case "/present":
            return self.present(target, from: from, wrap: nil,
                                style: .fullScreen, animated: animated, completion: nil)
        default:
            return nil
        }
    }
  
}

extension Routers: MediatorType {
    
    /// 根据RouterSourceType获取controller
    /// - Parameter target: target
    /// - Returns: controller
    public func viewController(of target: RouterTargetType) -> UIViewController? {
        guard let t = target as? RouterSourceType else {
            debugPrint("MEDIATOR WARNINIG: \(target) does not conform to MediatorSourceType")
            return nil
        }
        guard let viewController = t.viewController else { return nil }
        return viewController
    }
    
}


