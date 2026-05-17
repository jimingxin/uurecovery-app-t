//
//  NSDecimalNumber+KyoRound.swift
//  Kyo
//
//  Created by jimingxin on 2020/10/15.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

public protocol KyoRound {}
extension String: KyoRound {}
extension NSDecimalNumber: KyoRound {}

public extension NSDecimalNumber {
    
    /// 四舍五入
    ///
    /// - Parameters:
    ///   - fractionNum: 保留小数位的数量，不传则默认为保留2位小数
    ///   - identifier: 格式化采用的货币类型，默认"zh_CN"，即rmb
    /// - Returns: 返回指定类型数据
    func round<T>(type: T.Type = (String.self as! T.Type), fractionNum: Int = 2, localeIdentifier identifier: String = "zh_CN") -> T where T: KyoRound {
        return self.fround(type: T.self, fractionNum: fractionNum, localeIdentifier: identifier)
    }
    
    
    /// 向上取整
    /// - Parameters:
    ///   - fractionNum: 保留小数位的数量，不传则默认为保留2位小数
    ///   - identifier: 格式化采用的货币类型，默认"zh_CN"，即rmb
    /// - Returns: 返回指定类型数据
    func up<T>(type: T.Type = (String.self as! T.Type), fractionNum: Int = 2, localeIdentifier identifier: String = "zh_CN") -> T where T: KyoRound {
        return self.fround(type: T.self, fractionNum: fractionNum, localeIdentifier: identifier, roundingMode: .up)
    }
    
    /// 向下取整
    /// - Parameters:
    ///   - fractionNum: 保留小数位的数量，不传则默认为保留2位小数
    ///   - identifier: 格式化采用的货币类型，默认"zh_CN"，即rmb
    /// - Returns: 返回指定类型数据
    func down<T>(type: T.Type = (String.self as! T.Type), fractionNum: Int = 2, localeIdentifier identifier: String = "zh_CN") -> T where T: KyoRound {
        return self.fround(type: T.self, fractionNum: fractionNum, localeIdentifier: identifier, roundingMode: .down)
    }
    
    
    /// 指定位数直接显示
    /// - Parameters:
    ///   - fractionNum: 保留小数位的数量，不传则默认为保留2位小数
    ///   - identifier: 格式化采用的货币类型，默认"zh_CN"，即rmb
    /// - Returns: 返回指定类型数据
    func str(fractionNum: Int = 2, localeIdentifier identifier: String = "zh_CN") -> String {
       
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: identifier)
        formatter.numberStyle = .none   //不需要格式
        formatter.maximumFractionDigits = fractionNum    //小数位最多2位
        formatter.minimumFractionDigits = fractionNum    //小数位最少2位
        formatter.minimumIntegerDigits = 1    //整数位最少1位
        formatter.allowsFloats = true
        formatter.generatesDecimalNumbers = true
        let strFormatter: String = formatter.string(from: self) ?? self.stringValue
        return strFormatter
    }
    
    /// 四舍五入
    ///
    /// - Parameters:
    ///   - type: 枚举类型，在print或定义变量不指定类型时需要用指定这个参数
    ///   - fractionNum: 保留小数位的数量，不传则默认为保留2位小数
    ///   - identifier: 格式化采用的货币类型，默认"zh_CN"，即rmb
    ///   - roundingMode: 小数位保留方式
    /// - Returns: 返回指定类型数据
    fileprivate func fround<T>(type: T.Type, fractionNum: Int = 2, localeIdentifier identifier: String = "zh_CN", roundingMode: NSDecimalNumber.RoundingMode = .plain) -> T where T: KyoRound {
        let handler: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: roundingMode,
                                                                     scale: Int16(fractionNum),
                                                                     raiseOnExactness: false,
                                                                     raiseOnOverflow: false,
                                                                     raiseOnUnderflow: false,
                                                                     raiseOnDivideByZero: true)
        let roundNumber: NSDecimalNumber = self.rounding(accordingToBehavior: handler)
        
        if T.self is NSDecimalNumber.Type {
            return roundNumber as! T
        }
        
        if T.self is String.Type {
            let formatter: NumberFormatter = NumberFormatter()
            formatter.locale = Locale(identifier: identifier)
            formatter.numberStyle = .none   //不需要格式
            formatter.maximumFractionDigits = fractionNum    //小数位最多2位
            formatter.minimumFractionDigits = fractionNum    //小数位最少2位
            formatter.minimumIntegerDigits = 1    //整数位最少1位
            let strFormatter: String = formatter.string(from: roundNumber) ?? self.stringValue
            return strFormatter as! T
        }
        
        return self as! T
    }
}
