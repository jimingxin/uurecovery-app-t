//
//  UIView+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

extension UIView: CXNameSpace { }

extension CXKit where Base: UIView {
  
    public var x: CGFloat {
        get { return base.frame.origin.x }
        set { base.frame.origin.x = newValue }

    }
    public var y: CGFloat {
        get { return base.frame.origin.y }
        set { base.frame.origin.y = newValue }

    }
    public var width: CGFloat {
        get { return base.frame.size.width }
        set { base.frame.size.width = newValue }

    }
    public var height: CGFloat {
        get { return base.frame.size.height }
        set { base.frame.size.height = newValue }

    }
    public var left: CGFloat {
        get { return base.frame.origin.x }
        set { base.frame.origin.x = newValue }

    }
    public var right: CGFloat {
        get { return base.frame.origin.x + base.frame.size.width }
        set {
            var frame = base.frame
            frame.origin.x = newValue - base.frame.size.width
            base.frame = frame
        }
    }
    public var top: CGFloat {
        get { return base.frame.origin.y }
        set { base.frame.origin.y = newValue }

    }
    public var bottom: CGFloat {
        get { return base.frame.size.height + base.frame.origin.y }
        set {
            var frame = base.frame
            frame.origin.y = newValue - base.frame.size.height
            base.frame = frame
        }
    }
    public var center: CGPoint {
        get { return base.center }
        set { base.center = newValue }
    }
    public var centerX: CGFloat {
        get { return base.center.x }
        set { base.center.x = newValue }
    }
    
    public var centerY: CGFloat {
        get { return base.center.y }
        set { center.y = newValue }
    }
}

public extension UIView {
    
    /// 创建带背景颜色的View
    /// - Parameter color: color
    convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    
    }
    
    @IBInspectable
    /// 圆角
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    /// 边框宽度
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    /// 边框颜色
    @IBInspectable
    var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}

public extension CXKit where Base: UIView {
    
    enum GradientDirection: Int {
        case gradientToTop
        case gradientToLeft
        case gradientToBottom
        case gradientToRight
    }
    /// 移除所有子视图
    func clearViews() {
        for v in base.subviews {
            v.removeFromSuperview()
        }
    }
    /// 添加点击手势
    func addTapGesture(target: Any,
                       action: Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        base.isUserInteractionEnabled = true
        base.addGestureRecognizer(tap)
    }
    /// 设置渐变色
    /// - Parameters:
    ///   - color: 渐变色颜色数组
    ///   - direction: 渐变方向
    func setGradientBackgroundColors(_ colors: [UIColor],
                                        direction: GradientDirection) {
        let la = CAGradientLayer()
        la.frame = base.bounds
        base.layer.addSublayer(la)
        var marray: [CGColor] = [CGColor]()
        for color in colors {
            marray.append(color.cgColor)
        }
        la.colors = marray
        switch direction {
        case .gradientToTop:
            la.startPoint = CGPoint(x: 0.5, y: 1)
            la.endPoint = CGPoint(x: 0.5, y: 0)
        case .gradientToLeft:
            la.startPoint = CGPoint(x: 1, y: 0.5)
            la.endPoint = CGPoint(x: 0, y: 0.5)
        case .gradientToBottom:
            la.startPoint = CGPoint(x: 0.5, y: 0)
            la.endPoint = CGPoint(x: 0.5, y: 1)
        case .gradientToRight:
            la.startPoint = CGPoint(x: 0, y: 0.5)
            la.endPoint = CGPoint(x: 1, y: 0.5)
        }
    }


    var cornerSubscript: UILabel {
        get {
            guard let view = objc_getAssociatedObject(base, &AssociatedKeys.cornerSubscript) as? UILabel  else {
                let value = UILabel()
                value.text = ""
                value.backgroundColor = UIColor.red
                value.textColor = UIColor.white
                value.textAlignment = .center
                value.font = UIFont.cx.pingfangRegular(ofSize: 10)
                base.addSubview(value)
                value.frame = CGRect(x: base.cx.width - 8 - 5, y: 0 - 2, width: 16, height: 16)
                value.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 8).showVisual
                objc_setAssociatedObject(base, &AssociatedKeys.cornerSubscript, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

                return value
            }

            return view
        }
    }


    /// 设置角标的文字
    /// - Parameter text: 文字内容
    func setCornerSubscriptText(text: String, offset: CGFloat? = 5) {

        if text.cx.isBlank {
            cornerSubscript.text = text
            cornerSubscript.isHidden = true
            return
        }
        cornerSubscript.isHidden = false
        cornerSubscript.text = text
        guard var width = cornerSubscript.text?.cx.getWidth(font: cornerSubscript.font) else {
            return
        }
        width = width < 16 ? 16 : (width + 4)
        var temp_frame = cornerSubscript.frame
        temp_frame.origin.x = base.cx.width - (width / 2.0) - offset!;
        temp_frame.size.width = width
        cornerSubscript.frame = temp_frame
        cornerSubscript.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 8).showVisual
    }
    
    /// 添加红点
    /// - Parameters:
    ///   - right: 距离右边间距 default - 10
    ///   - top: 距离顶部间距 default - 10
    func setCornerDot(right: CGFloat = 10, top: CGFloat = 10) {
        let size: CGSize = base.frame.size
        cornerSubscript.frame = CGRect(x: size.width - right, y: top, width: 6, height: 6)
        cornerSubscript.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 3).showVisual
    }
}

fileprivate struct AssociatedKeys {
    static var cornerSubscript:Void?
}

   

