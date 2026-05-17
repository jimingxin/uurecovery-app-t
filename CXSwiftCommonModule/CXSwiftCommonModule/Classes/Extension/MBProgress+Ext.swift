//
//  MBProgress+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/5.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation

public struct HUD {
    
    
    /// Toast
    /// - Parameters:
    ///   - title: 说明文本
    ///   - icon: 图片
    ///   - view: 展示的视图
    ///   - second: 默认2.5s移除视图
    public static func showToast(title: String,
                                 icon: String? = "",
                                 view: UIView? = Utilits.controller?.view,
                                 second: TimeInterval = 2.5) {
        
        DispatchQueue.main.async {
            HUD.hidden()
            let _ = MBProgressHUD.showToast(title: title,
                                            icon: icon,
                                            view: view,
                                            second: second)
        }
    }
    /// 菊花加载loading
    /// - Parameters:
    ///   - title: 文本
    ///   - view: 视图: 默认添加到当前视图控制器上
    ///   - isWindow: 是否是添加到window: 默认否
    ///   - indicator: 默认: true 无背景菊花 false: 黑色背景菊花
    public static func showLoading(title: String? = "",
                                   view: UIView? = Utilits.controller?.view,
                                   isWindow: Bool? = false,
                                   indicator: Bool? = true) {
        
        var contentView = view
        if isWindow == true {
            contentView = UIWindow.key
        }
        hidden()
        let _ = MBProgressHUD.showLoding(title: title,
                                         view: contentView,
                                         indicator: indicator)
    }
    
    /// 移除HUD
    public static func hidden() {
        MBProgressHUD.hiddenHUD()
    }
   
}



public extension MBProgressHUD {
   
    static var _HUD: MBProgressHUD?
    // 提示类型
    enum HUDProgressType {
        case Success
        case Error
        case Warning
        case Info
    }
    private static func HUD(with view: UIView?) -> MBProgressHUD {
        var contentView = view
        if contentView == nil {
            contentView = UIWindow.key
        }
        let HUD = MBProgressHUD.showAdded(to: contentView!, animated: true)
        HUD.bezelView.style = .solidColor
        // 设置等待框背景色为黑色
        HUD.bezelView.backgroundColor = .black.withAlphaComponent(0.3)
        // 设置文字颜色
        HUD.contentColor = .white
        HUD.removeFromSuperViewOnHide = true
        return HUD
    }
    static func showToast(title: String,
                          icon: String? = "",
                          view: UIView?,
                          second: TimeInterval = 2.5) -> MBProgressHUD? {
        
        var HUD: MBProgressHUD?
        DispatchQueue.main.async {
            HUD = MBProgressHUD.HUD(with: view)
            if let imageSting = icon {
                HUD?.mode = .customView
                if imageSting.count > 0 {
                    HUD?.customView = UIImageView(image: UIImage(named: imageSting))
                }
                
            } else {
                HUD?.mode = .text
            }
            HUD?.detailsLabel.text = title
            HUD?.hide(animated: true, afterDelay: second)
        }
        return HUD
    }
    static func showLoding(title: String? = "",
                           view: UIView? = UIWindow.key,
                           indicator: Bool? = true ) -> MBProgressHUD? {
        
        var HUD: MBProgressHUD?
        
        DispatchQueue.main.async {
            HUD = MBProgressHUD.HUD(with: view)
            if indicator == true {
                HUD?.mode = .customView
                HUD?.bezelView.backgroundColor = .clear
                HUD?.contentColor = .lightGray
                
                var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
                indicatorView.removeFromSuperview()
                if #available(iOS 13.0, *) {
                    indicatorView = UIActivityIndicatorView(style: .large)
                } else {
                    indicatorView = UIActivityIndicatorView(style: .whiteLarge)
                }
                indicatorView.startAnimating()
                indicatorView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
                HUD?.customView = indicatorView
                
            } else {
                HUD?.mode = .indeterminate
            }
            HUD?.detailsLabel.text = title
            _HUD = HUD
        }
        return HUD
    }
    
    static func hiddenHUD() {
        DispatchQueue.main.async {
            _HUD?.hide(animated: true)
        }
    }
}
