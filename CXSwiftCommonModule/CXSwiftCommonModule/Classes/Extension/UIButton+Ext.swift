//
//  UIButton+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit


public extension UIButton {
    /// 快速创建button
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: 字体大小
    ///   - normalColor: 常规字体颜色
    ///   - selectedColor: 选中字体颜色
    ///   - highlightedColor: 高亮字体颜色
    convenience init(title: String?,
                     fontSize: CGFloat,
                     normalColor: UIColor,
                     image: UIImage? = nil,
                     selectedColor: UIColor? = nil,
                     highlightedColor: UIColor? = nil) {
        
        self.init(type: .custom)
        
        self.setTitle(title, for: .normal)

        self.setTitleColor(normalColor, for: .normal)
        if let selectedColor = selectedColor {
            self.setTitleColor(selectedColor, for: .selected)
        } else {
            self.setTitleColor(normalColor, for: .selected)
        }
        if let highlightedColor = highlightedColor {
            self.setTitleColor(highlightedColor, for: .highlighted)
        } else {
            self.setTitleColor(normalColor, for: .highlighted)
        }
        self.titleLabel?.font = UIFont.cx.pingfangRegular(ofSize: fontSize)
        self.adjustsImageWhenHighlighted = false
        setImage(image, for: .normal)
    }
    
    /// 创建一个图片Button
    /// - Parameter image: image
    convenience init(image: UIImage?) {
        self.init(type: .custom)
        setImage(image, for: .normal)
        self.adjustsImageWhenHighlighted = false
    }
  
}

public extension CXKit where Base: UIButton {
    // MARK: - 定义button相对label的位置
    enum ButtonImagePosition {
        case top          //图片在上，文字在下，垂直居中对齐
        case bottom       //图片在下，文字在上，垂直居中对齐
        case left         //图片在左，文字在右，水平居中对齐
        case right        //图片在右，文字在左，水平居中对齐
    }


    /// 设置button 标题 图片位置
    /// - Parameters:
    ///   - style: 样式
    ///   - spacing: 间距
    func imagePosition(style: ButtonImagePosition,
                       spacing: CGFloat) {
        
        //得到imageView和titleLabel的宽高
        let imageWidth = base.imageView?.frame.size.width
        let imageHeight = base.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = base.titleLabel?.intrinsicContentSize.width
        labelHeight = base.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
        }
        base.titleEdgeInsets = labelEdgeInsets
        base.imageEdgeInsets = imageEdgeInsets
    }

    /// 调整按钮图片的尺寸
      /// - Parameter inset: 传入需要设置的inset
      func imageAjustSize(inset: UIEdgeInsets) {

          let imageInset = base.imageEdgeInsets
          base.imageEdgeInsets = UIEdgeInsets(top: imageInset.top + inset.top, left: imageInset.left + inset.top, bottom: imageInset.bottom + inset.bottom, right: imageInset.right + inset.right)
          base.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
      }
}




