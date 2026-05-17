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
    static let sucess = 1000
    // 用户名或密码错误，请重新输入!
    static let pwdError = 1015
    // 1068: 账号已锁定
    static let accountLocked = 1068
    
    // json 解析错误error
    static let error_code = -999
    
    // 提现- 处理中状态
    static let status_withdrawl  = 4001

    struct ResponseModel<Result>: Convertible {
        var code: Int = 0
        var message: String = ""
        var traceId: String = ""
        var dataStamp: Int = 0
        var result: Result? = nil

    }
    struct Response: Convertible {
        
        var code: Int = 0
        var message: String = ""
        var traceId: String = ""
        var dataStamp: Int = 0
        
        var success: Bool {
            /// 1015: 用户名或密码错误，请重新输入!
            /// 1068: 账号已锁定
            // 1036 1038 4001 提现状态，显示成功 2114: 更换新设备需验证码登录
            return code == 1000 || code == 1015 || code == 1068 || code == 4001 || code == 1038 || code == 1036 || code == 2114 || code == 2109

        }
    }
    
    enum Error: Swift.Error {
        
        case status(code: Int, message: String, showloading: Bool)
        
        var code: Int {
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
    static func fastError(code: Int = Network.error_code, msg: String = "", showLoading: Bool = true) -> Network.Error {
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
