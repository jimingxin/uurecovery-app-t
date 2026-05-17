//
//  String+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/22.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit
import CommonCrypto

extension String: CXNameSpace { }


public extension CXKit where Base == String {
    
    /// 是否是空字符串
    var isBlank: Bool {
        return base.isEmpty || base.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    /// 移除空格
    func removeSpace() -> String {
        return base.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /// 将字符串通过特定的字符串拆分为字符串数组
    ///
    /// - Parameter string: 拆分数组使用的字符串
    /// - Returns: 字符串数组
    func split(string: String) -> [String] {
        return NSString(string: base).components(separatedBy: string)
    }
    /// 返回指定大小的image url
    /// - Parameters:
    ///   - w: width
    ///   - h: height
    /// - Returns: string
    func appendImageURL(w: Int8, h: Int8) -> String {
        return base + "?x-oss-process=image/resize,m_fill,h_" + "\(h)" + ",w_" + "\(w)"
    }
}

// MARK: - ================ 正则相关 ================
public extension CXKit where Base == String {
    func predicateBy(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: base)
    }
    /// 是否是手机号
    /// - Returns: bool
    var isMobile: Bool {
        let regex = "^1[0-9]{10}$"
        return self.predicateBy(regex)
    }
    
    /// 是否是字符数字
    var isAlphanumeric: Bool {
        return self.predicateBy("^a-zA-Z0-9]")
    }
    /// 是否是邮箱
    var isEmail: Bool {
        return base.range(of: ".") != nil && base.range(of: "@") != nil
    }
}

// MARK: - ================ 截取字符串 ================
public extension String {
    
    /// 根据下标获取某个下标字符
    subscript(of index: Int) -> String {
        if index < 0 || index >= self.count{
            return ""
        }
        for (i,item) in self.enumerated(){
            if index == i {
                return "\(item)"
            }
        }
        return ""
    }
    /// 根据range获取字符串 a[1...3]
    subscript(r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[0..<2]
    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[start..<end])
    }
    /// 根据range获取字符串 a[...2]
    subscript(r: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[startIndex...end])
    }
    /// 根据range获取字符串 a[0...]
    subscript(r: PartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: count - 1)
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[..<3]
    subscript(r: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[startIndex..<end])
    }
    /// 截取字符串: index 开始到结尾
    /// - Parameter index: 开始截取的index
    /// - Returns: string
    func subString(_ index: Int) -> String {
        guard index < count else {
            return ""
        }
        let start = self.index(endIndex, offsetBy: index - count)
        return String(self[start..<endIndex])
    }
    
    /// 截取字符串
    /// - Parameters:
    ///   - begin: 开始截取的索引
    ///   - count: 需要截取的个数
    /// - Returns: 字符串
    func substring(start: Int, _ count: Int) -> String {
        let begin = index(startIndex, offsetBy: max(0, start))
        let end = index(startIndex, offsetBy: min(count, start + count))
        return String(self[begin..<end])
    }
  
    
    
}
// MARK: - ================ 操作字符串 ================

public extension CXKit where Base == String {
    /// 替换指定范围内的字符串
    mutating func replaceStingWithIndex(index: Int,
                                        length: Int,
                                        replacText: String) -> String {
        
        if (index + length) >= base.count {
            return base
        }
        let startIndex = base.index(base.startIndex, offsetBy: index)
        base.replaceSubrange(startIndex..<base.index(startIndex, offsetBy: length),
                             with: replacText)
        return base
    }
    /// 替换指定Range内的字符串
    mutating func replaceStingWithRange(range: ClosedRange<Int>,
                                        replacText: String) -> String {
        if range.lowerBound >= base.count {
            return base
        }
        let start = base.index(base.startIndex, offsetBy: max(range.lowerBound, 0))
        let end = base.index(base.startIndex, offsetBy: min(range.upperBound, base.count - 1))
        base.replaceSubrange(start...end, with: replacText)
        return base
    }
    
    /// 替换指定字符串
    mutating func replaceTextByString(text: String,
                                      replacText: String) -> String {
        
        return base.replacingOccurrences(of: text, with: replacText)
    }
    
    ///删除最后一个字符
    mutating func deleteEndCharacters() -> String {
        
        base.remove(at: base.index(before: base.endIndex))
        return base
    }
    /// 删除指定字符串
    mutating func deleteString(string:String) -> String {
        
        return base.replacingOccurrences(of: string, with: "")
    }
    
    /// 字符的插入
    mutating func insertString(text:Character,
                               index:Int) -> String {
        
        if index >= base.count {
            return base
        }
        let start = base.index(base.startIndex, offsetBy: index)
        base.insert(text, at: start)
        return base
    }
    ///字符串的插入
    mutating func insertString(text:String,
                               index:Int) -> String {
        
        let start = base.index(base.startIndex, offsetBy: index)
        base.insert(contentsOf: text, at: start)
        return base
    }
    
   
}
// MARK: - ================ 类型编码 ================

public extension CXKit where Base == String {
    
    /// URL编码
    var urlEncoded: String {
        let characterSet = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`")
        return base.addingPercentEncoding(withAllowedCharacters: characterSet)!
    }
    /// URL解码
    var urlDecode: String? {
        return base.removingPercentEncoding
    }
    
    /// base64编码
    var base64: String {
        let plainData = (base as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    /// Base64解码
    var base64Decode: String? {
        
        if let data = Data(base64Encoded: base) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
}

// MARK: - ================ 字符串替换成值类型 ================

public extension String {
    ///变成Int 类型
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    /// 变成Double 类型
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    /// 变成Float 类型
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
}

// MARK: - ================ 获取文本的宽高 ================
public extension CXKit where Base == String {
    /// 获取文本高度
    ///
    /// - Parameters:
    ///   - font: font
    ///   - fixedWidth: fixedWidth
    /// - Returns: 高度
    func getHeight(font: UIFont,
                   fixedWidth: CGFloat) -> CGFloat {
        
        guard base.count > 0 && fixedWidth > 0 else { return 0 }
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = base as NSString
        let rect = text.boundingRect(with: size,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context:nil)
        return ceil(rect.size.height)
    }
    
    /// 获取文本高度
    /// - Parameters:
    ///   - font: font
    ///   - fixedWidth: fixedWidth
    ///   - lineSpace: 行间距
    /// - Returns: 高度
    func getHeight(font: UIFont,
                   fixedWidth: CGFloat,
                   lineSpace: CGFloat) -> CGFloat {
        
        guard base.count > 0 && fixedWidth > 0 else { return 0 }
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpace
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = base as NSString
        let rect = text.boundingRect(with: size,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: style],
                                     context:nil)
        return ceil(rect.size.height)
    }
    
    /// 获取文本宽度
    ///
    /// - Parameter font: font
    func getWidth(font: UIFont) -> CGFloat {
        
        guard base.count > 0 else {
            return 0
        }
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let text = base as NSString
        let rect = text.boundingRect(with: size,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context:nil)
        return ceil(rect.size.width)
    }
}

// MARK: - ================ 获取文本的宽高 ================
public extension CXKit where Base == String {
    
    /// 判断字符串是否为空
    /// - Returns: true - 为空 false - 不为空
    func isEmpty() -> Bool {
        if base.isEmpty || base.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return true
        }
        
        if base == "(null)" {
            return true
        }
        
        return false
    }
}

