//
//  UIViewController+Top.swift
//  SwiftRouter
//
//  Created by zain guo on 2020/9/12.
//  Copyright © 2020 zain guo. All rights reserved.
//

import UIKit


extension UIViewController {
    private class var sharedApplication: UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }
    
    
    /// 查找最底层的控制器
    open class var topMost: UIViewController? {
//        guard let currentWindows = self.sharedApplication?.windows else { return nil }
        var rootViewController: UIViewController?
        rootViewController = UIWindow.key?.rootViewController

        return self.topMost(of: rootViewController)
    }
    
    
    /// 递归寻找当前传入控制器最上面的Controller
    /// - Parameters:
    ///   - viewController: 当前控制器
    ///   - needChild: 是否需要递归子控制器 addChildController操作的
    /// - Returns: 查找到的控制器
    open class func topMost(of viewController: UIViewController?, needChild: Bool = true) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        if needChild {
            // 如果需要
            for subview in viewController?.view?.subviews ?? [] {
                if let childViewController = subview.next as? UIViewController {
                    return self.topMost(of: childViewController)
                }
            }
        }
        return viewController
    }
}

