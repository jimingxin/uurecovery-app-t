//
//  BaseViewModelProtocol.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/9/2.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

protocol BaseViewModelConfig {

    associatedtype In
    associatedtype Out

    var output: Out? { get set }
    // 初始化的配置
    func baseConfig() -> Void
    // Bind 模型
    func transform(input: In?) -> Void
    // init
    init(input: In?);
}
