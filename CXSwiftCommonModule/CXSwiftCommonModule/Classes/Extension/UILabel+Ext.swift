//
//  UILabel+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/22.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// 快随创建指定行数lab, 默认自动换行
    /// - Parameters:
    ///   - title: 文字
    ///   - textColor: 文字颜色
    ///   - fontSize: 文字大小(字体默认平方常规体)
    ///   - numOfLines: 文字行数
    ///   - alignment: 对齐方式
    convenience init(title: String?,
                     textColor: UIColor,
                     fontSize: CGFloat,
                     numOfLines: Int = 0,
                     alignment: NSTextAlignment = .left){
        
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.cx.pingfangRegular(ofSize: fontSize)
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
    }
    
    /// 快速创建单行Label
    /// - Parameters:
    ///   - title: 文字
    ///   - textColor: 颜色
    ///   - fontSize: 字体大小(字体默认平方常规体)
    convenience init(title: String?,
                     textColor: UIColor,
                     fontSize: CGFloat) {
        
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.cx.pingfangRegular(ofSize: fontSize)
    }
    
    /// 快速创建单行Label
    /// - Parameters:
    ///   - title: 文字
    ///   - textColor: 颜色
    ///   - blodSize: 字体大小(字体默认平方常规体)
    convenience init(title: String?,
                     textColor: UIColor,
                     blodSize: CGFloat) {
        
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.cx.pingfangMedium(ofSize: blodSize)
    }
}

// MARK: - ================ 富文本操作 ================

public extension CXKit where Base: UILabel {
    
    /// 改变字间距
    /// - Parameter space: space
    func changeWordSpace(_ space: CGFloat) {
        guard let title = base.text, title.isEmpty == false else { return }
        let attStr = NSMutableAttributedString.init(string: title)
        attStr.addAttribute(NSAttributedString.Key.kern, value: (space), range: NSMakeRange(0, title.count))
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: NSMutableParagraphStyle.init(), range: NSMakeRange(0, title.count))
        base.attributedText = attStr
        base.sizeToFit()
    }
    
    /// 改变行间距
    ///
    /// - Parameter space: space
    func changeLineSpace(space: CGFloat) {
        guard let title = base.text, title.isEmpty == false else { return }
        let attStr = NSMutableAttributedString.init(string: title)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = CGFloat(space)
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, title.count))
        base.attributedText = attStr
        base.sizeToFit()
    }
    
    /// 改变行间距和字间距
    ///
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - wordSpace: 字间距
    func changeLineSpaceAndWordSpace(lineSpace: CGFloat,
                                     wordSpace: CGFloat) {
        guard let title = base.text, title.isEmpty == false else { return }
        let attStr = NSMutableAttributedString.init(string: title)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, title.count))
        attStr.addAttribute(NSAttributedString.Key.kern, value: (wordSpace), range: NSMakeRange(0, title.count))
        base.attributedText = attStr
        base.sizeToFit()
    }
}



// MARK: - ================ 长按复制 ================

public extension UILabel {
    private struct AssociatedKeys {
        static let CopyTextKey = UnsafeRawPointer.init(bitPattern: "CopyTextKey".hashValue)
    }
    
    var copyText: String? {
        set {
            objc_setAssociatedObject(self, AssociatedKeys.CopyTextKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            isUserInteractionEnabled = true
            let LongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyEvent))
            addGestureRecognizer(LongPress)
        }
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.CopyTextKey!) as? String
        }
    }
    
    @objc func longPressCopyEvent() {
        // 让其成为响应者
        becomeFirstResponder()
        // 拿出菜单控制器单例
        let menu = UIMenuController.shared
        // 创建一个复制的item
        let copy = UIMenuItem(title: "copy", action: #selector(copyTitle))
        // 将复制的item交给菜单控制器（菜单控制器其实可以接受多个操作）
        menu.menuItems = [copy]
        // 设置菜单控制器的点击区域为这个控件的bounds
        menu.setTargetRect(bounds, in: self)
        // 显示菜单控制器，默认是不可见状态
        menu.setMenuVisible(true, animated: true)
    }
    @objc func copyTitle() {
        if copyText != nil {
            UIPasteboard.general.string = copyText
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copyTitle) {
            return true
        } else {
            return false
        }
    }
    /// 拥有成为响应者的能力
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
