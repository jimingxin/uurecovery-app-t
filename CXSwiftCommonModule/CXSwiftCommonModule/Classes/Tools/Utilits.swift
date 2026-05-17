//
//  Utilits.swift
//  CXMerchant
//
//  Created by zain guo on 2020/9/29.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

public struct Utilits {
    /// 获取当前视图控制器
    public static var controller: UIViewController? {
        var res: UIViewController?
        
        guard let window = UIApplication.shared.delegate?.window,
              let controller = window?.rootViewController else { return res }
        
        res = getVisibleController(controller)
        
        while res?.presentedViewController != nil {
            res = getVisibleController(res?.presentedViewController)
        }
        return res
    }
    private static func getVisibleController(_ vc: UIViewController?) -> UIViewController? {
        if vc is UINavigationController {
            return getVisibleController((vc as? UINavigationController)?.topViewController)
        } else if vc is UITabBarController {
            return getVisibleController((vc as? UITabBarController)?.selectedViewController)
        } else {
            return vc
        }
    }
    
    
    ///====================系统版本====================///
    public static func appVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    public static func OSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    public static func DeviceID() -> String {
        return UUID.init().uuidString
    }
}
