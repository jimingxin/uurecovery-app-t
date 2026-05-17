//
//  Kfingfisher+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/5.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit
import Kingfisher

public extension KingfisherWrapper where Base: UIImageView {
    
    /// 加载网络图片
    /// - Parameters:
    ///   - urlStr: url
    ///   - placeholder: 站位图片
    func setImage(_ urlStr: String?,
                  _ placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) {
        
        setImage(with: URL(string: urlStr ?? ""),
                 placeholder: placeholder,
                 options:[.transition(.fade(0.5))])

    }
}
public extension KingfisherWrapper where Base: UIButton {
    
    
    /// 设置UIButton网络图片
    /// - Parameters:
    ///   - urlStr: url
    ///   - state: state
    ///   - placeholder: 站位图片
    func setImage(_ urlStr: String?,
                  for state: UIControl.State,
                  _ placeholder: UIImage? = UIImage(named: "normal_placeholder_h"))  {
        
        setImage(with: URL(string: urlStr ?? ""),
                 for: state,
                 placeholder: placeholder,
                 options: [.transition(.fade(0.5))])
    }
}
