//
//  Network+Response.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/10.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import KakaJSON


extension Network {

    // 成功
    static let sucess = "S"
    // 用户名或密码错误，请重新输入!
    static let pwdError = 1015
    // 1068: 账号已锁定
    static let accountLocked = 1068
    
    // json 解析错误error
    static let error_code = "E"
    
    // 提现- 处理中状态
    static let status_withdrawl  = 4001
    
    
    // 分页数据
    struct PageModel: Convertible {
        let preIndex: Int = 0
        let curIndex: Int = 0
        let nextIndex: Int = 0
        let pageSize: Int = 0
        let count: Int = 0
        let pagesCount: Int = 0
        let firstIndex: Int = 0
        let pages: Int = 0
    }

    struct ResponseModel<Result>: Convertible {
        var code: String = ""
        var status: String = ""
        var msg: String = ""
        var success: Bool = true
        var count: Int = 0
        var data: Result? = nil
        var page:PageModel? = nil

    }
    struct Response: Convertible {
        
        var code: String = "E"
        var msg: String = ""
        var count: Int = 0
        
        var success: Bool {
            return code == "S"

        }
    }
    
    enum Error: Swift.Error {
        
        case status(code: String, message: String, showloading: Bool)
        
        var code: String {
            switch self {
            case .status(let code, _, _):
                return code
            }
        }
        var message: String {
            switch self {
            case .status(_ , let message, _):
                return message
            }
        }
        var showloading: Bool {
            switch self {
            case .status(_ , _ , let load):
                return load
            }
        }

        var localizedDescription: String {
            switch self {
            case .status(_ , let message, _):
                return message
            }
        }

    }
    
    
    /// 快捷创建Error
    /// - Parameters:
    ///   - code: 错误code
    ///   - msg: 错误信息
    ///   - showLoading: 是否显示错误
    /// - Returns: Network.Error对象
    static func fastError(code: String = Network.error_code, msg: String = "", showLoading: Bool = true) -> Network.Error {
       return Network.Error.status(code: code,
                                         message: msg,
                                         showloading: showLoading)
    }
}

extension Error {
    
    var messageForNetError: String {
        if let err = self as? Network.Error {
            return err.message
        }
        return ""
    }
}
