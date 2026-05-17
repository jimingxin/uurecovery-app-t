//
//  BaseView.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/8/27.
//  Copyright © 2020 zainguo. All rights reserved.
//
import UIKit

@objcMembers
public class BaseView: UIView {
    
    let disposeBag = DisposeBag()

    deinit {
        Const.log("==============🌺🌺🌺释放了\(type(of: self))==============\n")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseAddSubViews()
        baseAddConstraints()
        baseConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        baseAddSubViews()
        baseAddConstraints()
        baseConfig()
    }
}

extension BaseView: BaseViewConfig {
    func baseAddSubViews() { }

    func baseAddConstraints() { }

    func baseConfig() { }
}


