//
//  UIView+Effects.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/10/15.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

private struct EffectAssociatedKeys {
    static var effectConfig: Void?
    static var bezierPath:Void?
    static var shadowBackgroundView: Void?
    static var cornerSubscript:Void?
}

// 用于配置圆角
class EffectConfig {
    // 圆角类型
    var conrnerCorner: UIRectCorner = .allCorners
    var conrnerRadius: CGFloat = 0
    var borderColor: UIColor = .black
    var borderWidth: CGFloat = 0
    var shadowColor: UIColor = .black
    var shadowOffset: CGSize = CGSize.zero
    var shadowRadius: CGFloat = 0
    var shadowOpacity: CGFloat = 0
    var viewBounds: CGRect = CGRect.zero
    var bezierPath: UIBezierPath?
    var dashPattern: [NSNumber]?

}

public extension UIView {

    @discardableResult
    func conrnerCorner(corner: UIRectCorner) -> UIView {
        self.effectConfig.conrnerCorner = corner
        return self
    }

    @discardableResult
    func conrnerRadius(radius: CGFloat) -> UIView {
        self.effectConfig.conrnerRadius = radius
        return self
    }

    @discardableResult
    func borderColor(color: UIColor) -> UIView {
        self.effectConfig.borderColor = color
        return self
    }

    @discardableResult
    func borderWidth(width: CGFloat) -> UIView {
        self.effectConfig.borderWidth = width
        return self
    }

    @discardableResult
    func shadowColor(color: UIColor) -> UIView {
        self.effectConfig.shadowColor = color
        return self
    }

    @discardableResult
    func shadowOffset(size: CGSize) -> UIView {
        self.effectConfig.shadowOffset = size
        return self
    }

    @discardableResult
    func shadowRadius(radius: CGFloat) -> UIView {
        self.effectConfig.shadowRadius = radius
        return self
    }

    @discardableResult
    func shadowOpacity(opacity: CGFloat) -> UIView {
        self.effectConfig.shadowOpacity = opacity
        return self
    }

    @discardableResult
    func viewBounds(bounds: CGRect) -> UIView {
        self.effectConfig.viewBounds = bounds
        return self
    }

    @discardableResult
    func bezierPath(bezier: UIBezierPath) -> UIView {
        self.effectConfig.bezierPath = bezier
        return self
    }
    @discardableResult
    /// [5, 2]: 5是线的长度 2: 是跳过
    func dashPattern(pattern: [NSNumber]) -> UIView {
        self.effectConfig.dashPattern = pattern
        return self
    }
}

public extension UIView {
    var clearVisual: UIView {

        @discardableResult
        get{
            // 阴影
            if let v = self.shadowBackgroundView {
                v.removeFromSuperview()
            }

            // 圆角边框
            if let layers = self.layer.sublayers {
                let arr_layers = layers.map({$0})
                for layer in arr_layers {
                    if let name = layer.name, name == "CCViewEffects" {
                        layer.removeFromSuperlayer()
                    }
                }
            }

            // 恢复默认数据
            self.effectConfig = EffectConfig()

            // 自身的属性
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 0
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0
            self.layer.shadowPath = nil
            self.layer.shadowRadius = 0
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize.zero
            self.layer.mask = nil

            return self
        }
    }

    var showVisual: Void {
        get{
            self.addShadow()
            self.addBorderAndRadius()
            return ()
        }

    }
}

public extension UIView {
    func addShadow()  {

        var shadowView = UIView()

        // 同时存在阴影和圆角
        if (self.effectConfig.shadowOpacity > 0 && self.effectConfig.conrnerRadius > 0) ||
            self.effectConfig.bezierPath != nil  {

            // 阴影
            if let v = self.shadowBackgroundView {
                v.removeFromSuperview()
            }

            if let superView = self.superview {
                shadowView = UIView(frame: self.frame)
                shadowView.backgroundColor = .clear
                shadowView.translatesAutoresizingMaskIntoConstraints = false
                superView.insertSubview(shadowView, belowSubview: self)
                // 添加约束
                superView.addConstraints([
                    NSLayoutConstraint(item: shadowView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: shadowView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: shadowView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: shadowView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
                ])
                self.shadowBackgroundView = shadowView
            }

        }

        // 圆角
        if self.effectConfig.conrnerRadius > 0 ||
            self.effectConfig.bezierPath != nil {
            
            let bezierPath = self.drawBezierPath()
            shadowView.layer.shadowPath = bezierPath.cgPath
        }
        // 阴影
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = Float(self.effectConfig.shadowOpacity)
        shadowView.layer.shadowRadius = self.effectConfig.shadowRadius
        shadowView.layer.shadowOffset = self.effectConfig.shadowOffset
        shadowView.layer.shadowColor = self.effectConfig.shadowColor.cgColor
    }

    func addBorderAndRadius()  {

        if (self.effectConfig.shadowOpacity > 0 ||
            self.effectConfig.conrnerRadius > 0) ||
            self.effectConfig.bezierPath != nil{

            // 圆角
            if self.effectConfig.conrnerRadius > 0 ||
                self.effectConfig.bezierPath != nil{
                let path = drawBezierPath()
                let maskLahyer = CAShapeLayer()
                maskLahyer.frame = self.bounds
                maskLahyer.path = path.cgPath
                self.layer.mask = maskLahyer
            }

            // 边框
            if self.effectConfig.borderWidth > 0 ||
                self.effectConfig.bezierPath != nil{

                if let layers = self.layer.sublayers {
                    let arr_layers = layers.map({$0})
                    for layer in arr_layers {
                        if let name = layer.name, name == "CCViewEffects" {
                            layer.removeFromSuperlayer()
                        }
                    }
                }

                let path = drawBezierPath()
                let layer = CAShapeLayer()
                layer.name = "CCViewEffects"
                layer.frame = self.bounds
                layer.path = path.cgPath
                layer.lineWidth = self.effectConfig.borderWidth
                layer.lineDashPattern = self.effectConfig.dashPattern
                layer.strokeColor = self.effectConfig.borderColor.cgColor
                layer.fillColor = UIColor.clear.cgColor
                self.layer.addSublayer(layer)
            }

        } else {
            //只有边框
            self.layer.masksToBounds = true
            self.layer.borderWidth = self.effectConfig.borderWidth
            self.layer.borderColor = self.effectConfig.borderColor.cgColor
        }
    }


    func drawBezierPath() -> UIBezierPath {
        if let bezierPath = self.effectConfig.bezierPath {
            return bezierPath
        }
        return UIBezierPath(roundedRect: drawBounds(),
                            byRoundingCorners: self.effectConfig.conrnerCorner,
                            cornerRadii: CGSize(width: self.effectConfig.conrnerRadius,
                                                height: self.effectConfig.conrnerRadius))
    }


    func drawBounds() -> CGRect {
        // 如果传入了大小
        guard self.effectConfig.viewBounds.width > 0 ,self.effectConfig.viewBounds.height > 0  else{
            if let superview = self.superview {
                superview.layoutIfNeeded()
            }
            return self.bounds
        }

        return self.effectConfig.viewBounds
    }
}

extension UIView {

    /// 用于做圆角的配置类
    var effectConfig: EffectConfig {
        get {
            guard let config = objc_getAssociatedObject(self, &EffectAssociatedKeys.effectConfig) as? EffectConfig  else {
                let value = EffectConfig()
                objc_setAssociatedObject(self, &EffectAssociatedKeys.effectConfig, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return value
            }

            return config
        }
        set {
            objc_setAssociatedObject(self, &EffectAssociatedKeys.effectConfig, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }


    var shadowBackgroundView: UIView? {
        get {
            let view = objc_getAssociatedObject(self, &EffectAssociatedKeys.shadowBackgroundView) as? UIView
            return view
        }
        set {
            objc_setAssociatedObject(self, &EffectAssociatedKeys.shadowBackgroundView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

