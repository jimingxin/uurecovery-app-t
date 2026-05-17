//
//  BaseViewControllerConfig.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/9.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

public protocol BaseControllerConfig {
    
    func baseAddSubViews()
    func baseAddConstraints()
    func baseConfig()
    func configNavigationBar()
    func bindViewModel()
}

/// 编辑完成是否需要刷新页面
@objc
public protocol EditModelRefreshProtocol {
    // 编辑完成是否需要刷新
    @objc optional func editModelRefresh()
    
    // 添加完成后回调
    @objc optional func addModelRefresh()

    
    // 编辑完成页面即将销毁
    @objc optional func editModelRefreshDestroy()
    
    // 编辑的模型被删除
    @objc optional func editModelRefreshIsDeleted()
}

