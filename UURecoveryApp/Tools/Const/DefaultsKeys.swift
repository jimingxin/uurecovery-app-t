//
//  DefaultsKeys.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/14.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

import DefaultsKit
import CoreMedia

public let userDefaults = Defaults()


struct MXDefaultKey {
    /// 用户信息
    /// 是否登录
    static let userInfo = Key<Resp.LoginRespModel>("USER_INFO")
    static let isLogin = Key<Bool>("MX_IS_LOGIN")
    // 厂商标识
    static let idfv = Key<String>("MX_IDFV")
    
    static let timeOut = Key<Int>("TIME_OUT")
    // 存放时间戳
    static let timeInterval = Key<TimeInterval>("TIME_INTERVAL")
    /// 省市区城市版本
    static let cityAreaVersion = Key<String>("CX_CITY_AREA_VERSION")
    /// app版本号 服务器
    static let appVersion = Key<String>("CX_APP_VERSION")
    /// app Build号 服务器
    static let appBuild = Key<String>("CX_APP_BUILD_VERSION")
    /// 百度定位
    static let firstLocation = Key<Bool>("CX_FISRT_LOCATION_AUTHORIZATION")
    
    // 产品数据缓存
    static let yy_products = Key<[Resp.ProductModel]>("YY_PRODUCTS")
    
    // 常见问题
    static let yy_questions = Key<[Resp.QuestionModel]>("YY_QUESTIONS")
    
    // 版本号
    static let yy_version = Key<String>("YY_VERSION")
    
    // 支付订单的订单号
    static let yy_order_no_paid = Key<String>("YY_ORDER_NO_PAID")
    
    // 保存的客服
    static let yy_kefu_mod = Key<Resp.CmrItemModel>("YY_KEFU_MOD")

}

//extension DefaultsKey {
//    
//    /// 用户信息
//    /// 是否登录
//    static let userInfo = Key<Resp.LoginRespModel>("USER_INFO")
//    static let isLogin = Key<Bool>("MX_IS_LOGIN")
//    // 厂商标识
//    static let idfv = Key<String>("MX_IDFV")
//    
//    static let timeOut = Key<Int>("TIME_OUT")
//    // 存放时间戳
//    static let timeInterval = Key<TimeInterval>("TIME_INTERVAL")
//    /// 省市区城市版本
//    static let cityAreaVersion = Key<String>("CX_CITY_AREA_VERSION")
//    /// app版本号 服务器
//    static let appVersion = Key<String>("CX_APP_VERSION")
//    /// app Build号 服务器
//    static let appBuild = Key<String>("CX_APP_BUILD_VERSION")
//    /// 百度定位
//    static let firstLocation = Key<Bool>("CX_FISRT_LOCATION_AUTHORIZATION")
//    
//    // 产品数据缓存
//    static let yy_products = Key<[Resp.ProductModel]>("YY_PRODUCTS")
//    
//    // 常见问题
//    static let yy_questions = Key<[Resp.QuestionModel]>("YY_QUESTIONS")
//
//}
