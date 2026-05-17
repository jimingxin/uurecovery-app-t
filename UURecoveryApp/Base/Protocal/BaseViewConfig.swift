//
//  BaseViewPortocal.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/8/26.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

protocol BaseViewConfig {
    func baseAddSubViews()
    func baseAddConstraints()
    func baseConfig()
}

protocol BaseViewXib {
    associatedtype T
    static func instantiateFromNib(nibName: String) -> T
}


extension BaseViewXib {
    static func instantiateFromNib(nibName: String) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! T
    }
}
