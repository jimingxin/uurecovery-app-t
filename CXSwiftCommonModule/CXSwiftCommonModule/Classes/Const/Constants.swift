//
//  Constants.swift
//  SwiftDemo
//
//  Created by 孟卫东 on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

public struct Const { }

///====================Size====================///
public extension Const {
    
    static let tag = 100
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let globalCorner: CGFloat = 8
    /// 状态栏高度
    static var statusBarHeight: CGFloat {

        guard UI_USER_INTERFACE_IDIOM() == .phone else { return 0 }
        guard #available(iOS 11.0, *) else { return 0}
        guard let window = UIApplication.shared.windows.first else { return 0 }
        return window.safeAreaInsets.top
//        guard isIphoneX else {
//            return 20
//        }
//        if #available(iOS 14.0, *) {
//            return 48
//        } else {
//            return 44
//        }
    }
    
    static var safeAreaHeight: CGFloat {
        guard UI_USER_INTERFACE_IDIOM() == .phone else { return 0 }
        guard #available(iOS 11.0, *) else { return 0}
        guard let window = UIApplication.shared.windows.first else { return 0 }
        return window.safeAreaInsets.bottom
    }
    
    /// 导航栏高度
    static let realNavBarHeight: CGFloat = 44
    /// Tabbar高度
    static let tabBarHeight: CGFloat = 49
    /// 安全区域的高度
    static let bottomSafeHeight: CGFloat = isIphoneX ? 34 : 0
    /// 顶部导航高度
    static let navBarHeight: CGFloat = statusBarHeight + realNavBarHeight
    /// 包含底部toolbar和安全区域
    static let bottomTabBarHeight: CGFloat = tabBarHeight + safeAreaHeight
    /// 宽度比
    static let widthRatio = screenWidth / 375.0
    /// 是否是iphoneX
    static var isIphoneX: Bool {
        
        guard UI_USER_INTERFACE_IDIOM() == .phone else { return false }
        guard #available(iOS 11.0, *) else { return false}
        guard let window = UIApplication.shared.windows.first else { return false }
        let isX = window.safeAreaInsets.bottom > 0
        return isX
    }

    // padding
    static let padding: CGFloat = 16.0
    
}

// MARK: - 字体和高度
public extension Const {
    /// 自适应宽度
    static func adaptWidth(_ value : CGFloat) -> CGFloat {
        return ceil(value) * widthRatio
    }
    /// 自适应高度
    static  func adaptHeight(_ value : CGFloat) -> CGFloat {
        return ceil(value) * widthRatio
    }
    ///====================字体====================///
    static func font375(font: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: adaptWidth(font))
    }
    
    static func BoldFont375(font: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: adaptWidth(font))
    }
    
    static func pingfang_RegularFont375(font: CGFloat) -> UIFont {
        return UIFont.cx.pingfangRegular(ofSize: adaptWidth(font))
    }
    
    static func pingfang_MediumFont375(font: CGFloat) -> UIFont {
        return UIFont.cx.pingfangMedium(ofSize: adaptWidth(font))

    }
    
    static func pingFang_SemiboldFont375(font: CGFloat) -> UIFont {
        return UIFont.cx.pingfangSemibold(ofSize: adaptWidth(font))
    }
    
    
}
// MARK: - Other
public extension Const {
    ///====================系统版本====================///
    static func appVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    static func OSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    static func DeviceID() -> String {
        return UUID.init().uuidString
    }
    
    /// 自定义打印方法
    static func log<T>(_ message: T,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        debugPrint("\(fileName):(\(line)) 时间:\(dateString)\n\(message)")
        #endif
    }
}
