//
//  Image+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/5.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit


extension UIImage: CXNameSpace { }


public extension CXKit where Base: UIImage {
    /// 创建一个纯色image
    static func imageWithColor(_ imageColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(imageColor.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    /// 根据颜色以及size生成image
    static func imageWithColor(_ color: UIColor,
                               size: CGSize,
                               radius: CGFloat? = nil) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: size.width, height: size.height), true, UIScreen.main.scale)
        color.set()
        UIRectFill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let rad = radius else { return image }
        let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: size), cornerRadius: rad)
        UIGraphicsBeginImageContext(size)
        guard let ctx = UIGraphicsGetCurrentContext() else { return image }
        ctx.addPath(path.cgPath)
        ctx.clip()
        image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let r_image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return r_image
    }
    
    /// view转image
    static func imageWithView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 原图
    func originalImage() -> UIImage {
        base.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
}


