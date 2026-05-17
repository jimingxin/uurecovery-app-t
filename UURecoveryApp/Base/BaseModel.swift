//
//  BaseModel.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/9/2.
//  Copyright © 2020 zainguo. All rights reserved.
//

import KakaJSON

protocol BaseModelProtocol {

    associatedtype Element
    var code: String { get }
    var message: String { get }
    var traceId: String { get }
    var dataStamp: Int { get }
    var result: Element? { get }
}

struct BaseModel<Element>: Convertible, BaseModelProtocol {

    let code = ""
    let message = ""
    let traceId: String = ""
    let dataStamp: Int = 0
    let result: Element? = nil
    
}
