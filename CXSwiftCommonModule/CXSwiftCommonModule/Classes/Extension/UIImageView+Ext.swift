//
//  UIImageView+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/22.
//  Copyright © 2020 canshi. All rights reserved.
//

import Kingfisher
import UIKit


public extension UIImageView {
    
    /// 快速生成UIImageView
    /// - Parameter imageName: 图片名字
    convenience init(imageName: String) {
        self.init()
        let image = UIImage(named: imageName)
        self.image = image
    }
}

public extension CXKit where Base: UIImageView {
    
    func setImage(_ urlStr: String?,
                  _ placeholder: UIImage = UIImage(named: "normal_placeholder_h")!) {
        
        guard let urlStr = urlStr else { return }
        guard let url = URL(string: urlStr) else {
            debugPrint("😯😯😯😯error😯😯😯😯============\n\n url:|\(urlStr)|无法解析为URL类型")
            base.image = placeholder
            return
        }
        base.kf.setImage(with: url,
                         placeholder: placeholder)
    }
}

