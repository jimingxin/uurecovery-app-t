//
//  BaseViewModel.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/9/2.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit


struct BaseInput { }

struct BaseOutput { }

class BaseViewModel<In, Out>: NSObject, BaseViewModelConfig {

    let disposeBag = DisposeBag()
    /// 分页个数
    var pageSize: Int = 15
    /// 页码
    var pageNum: Int = 1

    var output: Out?

    required init(input: In? = nil) {
        super.init()
        baseConfig()
        transform(input: input)
    }

    func baseConfig() { }

    func transform(input: In?) { }

    deinit {
        Const.log("==============🏭🏭🏭释放了\(type(of: self))==============\n")
    }
}
