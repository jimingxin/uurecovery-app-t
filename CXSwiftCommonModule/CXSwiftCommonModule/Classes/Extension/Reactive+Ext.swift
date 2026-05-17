//
//  Reactive+Ext.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/19.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base == UIImageView {
    public var urlImage: Binder<String> {
        return Binder(base) { (imageView, url) in
            imageView.kf.setImage(url)
        }
    }
}
