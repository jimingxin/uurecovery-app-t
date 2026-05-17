//
//  UIColor+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(r: CGFloat,
                     g: CGFloat,
                     b: CGFloat,
                     alpha: CGFloat = 1.0) {
        
        self.init(red: r / 255.0,
                  green: g / 255.0,
                  blue: b / 255.0,
                  alpha: alpha)
    }
    // 16进制颜色
    class func hex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.clear }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.clear }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(r: CGFloat(r),
                       g: CGFloat(g),
                       b: CGFloat(b),
                       alpha: alpha)
    }
    /// 随机色
    static var random: UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)),
                       g: CGFloat(arc4random_uniform(256)),
                       b: CGFloat(arc4random_uniform(256)))
    }
}

