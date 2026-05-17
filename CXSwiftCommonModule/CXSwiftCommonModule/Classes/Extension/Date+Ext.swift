//
//  Date+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/22.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation

extension Date: CXNameSpace { }

public extension Date {
    
    static let minutesInAWeek = 24 * 60 * 7

    /// 根据时间获取年
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    /// 根据时间获取月份
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    /// 根据时间获取日期
    var day: Int {
        return Calendar.current.component(Calendar.Component.day, from: self)
    }
    /// 根据时间获取时
    var hour: Int {
        return Calendar.current.component(Calendar.Component.hour, from: self)
    }
    /// 根据时间获取分
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    /// 根据时间获取秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    /// 是否是今天
    var isToday: Bool {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateformatter.string(from: self)
        let nowStr = dateformatter.string(from: Date())
        return dateStr == nowStr
    }
    
    /// 是否是昨天
    var isYesterday: Bool {
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter.string(from: self) == dateformatter.string(from: yesterDay!)
    }
    /// 是否是明天
    var isTomorrow: Bool {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return dateformatter.string(from: self) == dateformatter.string(from: tomorrow!)
    }
    /// 是否是当月
    var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    /// 是否是本周
    var isThisWeek: Bool {
        return self.minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    /// 计算从现在到现在经过了多少天
    func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/86400)
        return diff
    }
    /// 计算从现在到现在经过了多少了多少小时
    func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/3600)
        return diff
    }
    /// 计算从现在到现在经过了多少了多少分钟
    func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/60)
        return diff
    }
    /// 计算从现在到现在经过了多少了多少秒
    func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff)
        return diff
    }
    
}
// MARK: - ================ 格式化时间枚举 ================

public extension Date {
    enum DateFormatterMode: String {
        case dateModeY = "yyyy"
        case dateModeYM = "yyyy-MM"
        case dateModeYMD = "yyyy-MM-dd"
        case dateModeYMDHM = "yyyy-MM-dd HH:mm"
        case dateModeYMDHMS = "yyyy-MM-dd HH:mm:ss"
        case dateModeYMDHMSSS = "yyyy-MM-dd HH:mm:ss SSS"
        case dateModeYMDChinese = "yyyy年MM月dd日"
    }
}
// MARK: - ================ Date操作 ================

public extension Date {
    
    
    /// 获取当前 毫秒级 时间戳: 13位
    var milliTimeStamp: String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval * 1000))
        return "\(millisecond)"
    }
    
    /// 获取当前 秒级 时间戳: 10位
    var timeStamp: String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    /// Date转格式化时间字符串
    /// - Parameter mode: 时间格式化字符串格式 默认: yyyy-MM-dd
    /// - Returns: 格式化时间字符串
    func toString(_ mode: String = DateFormatterMode.dateModeYMD.rawValue) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mode
        return dateFormatter.string(from: self)
    }
    
    /// 返回DateFormatter
    /// - Parameter model: 模式
    /// - Returns: DateFormatter
    static func dateFmt(_ model: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = model
        return dateFormatter
    }
    
    /// 格式化时间字符串转成时间戳
    /// - Parameters:
    ///   - stringTime: 格式化时间字符串
    ///   - isMill: 是否是毫秒
    /// - Returns: 时间戳
    static func stringToTimeStamp(_ stringTime: String,
                                  isMill: Bool) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: stringTime)
        let dateStamp: TimeInterval = date!.timeIntervalSince1970
        let dateSt: Int = Int(dateStamp)
        
        return isMill ? dateSt * 1000 : dateSt
    }
    
  
    /// 时间戳转换为格式化字符串
    /// - Parameters:
    ///   - timeStamp: 时间戳
    ///   - model: 时间格式化字符串格式 默认: yyyy年MM月dd日
    /// - Returns: 格式化时间字符串
    static func timeStampToString(_ timeStamp: String,
                                  model: String = DateFormatterMode.dateModeYMDChinese.rawValue) -> String {
        
        guard var timeSta: TimeInterval = Double(timeStamp) else {
            return ""
        }
        if timeStamp.count == 13 {
            /// 毫秒时间字符串
            timeSta = timeSta / 1000
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = model
        let date = Date(timeIntervalSince1970: timeSta)
        return dateFormatter.string(from: date)
    }
    
    /// 时间字符串转Date
    /// - Parameter dateStr: 时间格式化字符串
    /// - Returns: Date
    static func timeStringToDate(_ dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    
    /// 比较时间先后
    /// - Parameters:
    ///   - oneDay: one
    ///   - anotherDay: another
    /// - Returns: 0: 相同 1: oneDay大 2: anotherDay大
    static func compareOneDay(oneDay: Date,
                              anotherDay: Date) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr: String = dateFormatter.string(from: oneDay)
        let anotherDayStr: String = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result: ComparisonResult = (dateA?.compare(dateB!))!
        
        if result == ComparisonResult.orderedDescending {
            // Date1 早
            return 1
            
        } else if result == ComparisonResult.orderedAscending {
            // Date1 晚
            return 2
            
        } else {
            // 相等
            return 0
        }
    }
    
    /// 将时间显示为（几分钟前，几小时前，几天前）
    /// - Parameter timeStr: 格式化时间字符串
    /// - Returns: String
    static func compareCurrentTime(timeStr: String) -> String {
        
        guard let tiemDate = self.timeStringToDate(timeStr) else {
            return ""
        }
        let currentDate = Date()
        let tiemInterval = currentDate.timeIntervalSince(tiemDate)
        var temp: Double = 0
        var result: String = ""
        if tiemInterval/60 < 1 {
            result = "刚刚"
        } else if tiemInterval/60 < 60 {
            temp = tiemInterval/60
            result = "\(Int(temp))分钟前"
        } else if tiemInterval/60/60 < 24 {
            temp = tiemInterval/60/60
            result = "\(Int(temp))小时前"
        } else if tiemInterval/60/60/24 < 30 {
            temp = tiemInterval/60/60/24
            result = "\(Int(temp))天前"
        } else if tiemInterval/(60 * 60 * 24 * 30) < 12 {
            temp = tiemInterval/(60 * 60 * 24 * 30)
            result = "\(Int(temp))个月前"
        } else {
            temp = tiemInterval/(12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp))年前"
        }
        return result
    }
}

public extension Date {
    
    /// 返回某个Date 前n/后n个月时的Date
    /// - Parameter month: 月数 正数: 后n个月 负数: 前n个月
    /// - Returns: Date
    func priousorLaterDate(with month: Int) -> Date? {
        var components = DateComponents.init()
        components.month = month
        let calender = Calendar(identifier: .gregorian)
        let date = calender.date(byAdding: components, to: self)
        return date
    }
}
