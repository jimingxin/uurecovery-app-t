//
//  NSAttributedString+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/23.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    return ns
}
 
extension NSAttributedString {
    /// 加粗
    public func bold() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }
    
    /// 下划线
    public func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        return copy
    }
    
    /// 删除线
    public func strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)]
        copy.addAttributes(attributes, range: range)
        return copy
    }
    
    /// 前景色
    /// - Parameter color: color description
    public func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }
    
    /// Range 设置前景色
    /// - Parameter color: color description
    public func colorRange(_ color: UIColor, range: NSRange) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }

    /// 设置行间距
    /// - Parameter lineSpaing: 行间距
    /// - Returns: 设置行间距
    public func lineSpacing(lineSpaing: CGFloat) -> NSAttributedString{

        guard let copy = self.mutableCopy() as? NSMutableAttributedString
              else { return self }

        var range: NSRange = NSRange(location: 0, length: copy.length)
        let point = withUnsafeMutablePointer(to: &range) { $0 }
        let dic_attributed = copy.attributes(at: 0, effectiveRange: point)

        var style =  dic_attributed[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
        if  let _ = style{ } else {
            style = NSMutableParagraphStyle()
        }

        style?.lineSpacing = lineSpaing
        copy.addAttributes([NSAttributedString.Key.paragraphStyle: style!], range: range)
        return copy
    }
    
    /// 字体
    public func font(font: CGFloat) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.cx.pingfangRegular(ofSize: font)], range: range)
        return copy
    }
    
    /// 文字大小
    /// - Parameter fontSize: fontSize
    public func fontRange(_ font: CGFloat, rangeString: String) -> NSAttributedString {
        
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (self.string as NSString).range(of: rangeString)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.cx.pingfangRegular(ofSize: font)], range: range)
        return copy
    }
    
}
