//
//  UIWindow.swift
//  CXSwiftCommonModule
//
//  Created by zain guo on 2020/10/15.
//

import Foundation

// MARK: - Key Window
public extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            for scene in UIApplication.shared.connectedScenes {
                if let windowScene = scene as? UIWindowScene,  windowScene.activationState == UIScene.ActivationState.foregroundActive {
                   let windows = windowScene.windows.sorted { (w1, w2) -> Bool in
                       return w1.tag > w2.tag
                    }
                    return windows.first
                }
            }
            return nil
        } else {
            return UIApplication.shared.windows.sorted { (w1, w2) -> Bool in
                return w1.tag > w2.tag
            }.first

        }
    }
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.sorted { (w1, w2) -> Bool in
            return w1.tag > w2.tag
        }.first
    }
}



