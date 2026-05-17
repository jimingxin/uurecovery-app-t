//
//  UIFont+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

extension UIFont: CXNameSpace{}

public extension CXKit where Base: UIFont {
    enum FontType: String {
        // 苹方-简 常规体
        case pingFangSC_Regular = "PingFangSC-Regular"
        // 苹方-简 中粗体
        case pingFangSC_Semibold = "PingFangSC-Semibold"
        // 苹方-简 中黑体
        case pingFangSC_Medium = "PingFangSC-Medium"
        // 苹方-简 细体
        case pingFangSC_Light = "PingFangSC-Light"
        // 苹方-简 极细体
        case pingFangSC_Ultralight = "PingFangSC-Ultralight"
        // 苹方-简 纤细体
        case pingFangSC_Thin = "PingFangSC-Thin"
    }

    static func pingfangRegular(ofSize fontSize: CGFloat) -> UIFont {
        // 苹方-简 常规体
        return UIFont.fontName(name: FontType.pingFangSC_Regular.rawValue, fontSize: fontSize)
    }
    static func pingfangMedium(ofSize fontSize: CGFloat) -> UIFont {
        // 苹方-简 中黑体
        return UIFont.fontName(name: FontType.pingFangSC_Medium.rawValue, fontSize: fontSize)
    }
    static func pingfangSemibold(ofSize fontSize: CGFloat) -> UIFont {
        // 苹方-简 中粗体
        return UIFont.fontName(name: FontType.pingFangSC_Semibold.rawValue, fontSize: fontSize)
    }
}

extension UIFont {
    fileprivate static func fontName(name: String, fontSize: CGFloat) -> UIFont {
        return UIFont(name: name, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
