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


extension DefaultsKey {
    
    /// 用户信息
    /// 省市区城市版本
    static let cityAreaVersion = Key<String>("CX_CITY_AREA_VERSION")
    /// 个推ClentID
    static let geTuiClentID = Key<String>("CX_CLIENT_ID")
    /// 商户入驻信息
    static let registerInfo = Key<String>("CX_REGISTER_INFO")
    /// 所属分类数据源
    static let industrylist = Key<String>("CX_INDUSTRYLIST_DATA")
    /// app版本号 服务器
    static let appVersion = Key<String>("CX_APP_VERSION")
    /// app Build号 服务器
    static let appBuild = Key<String>("CX_APP_BUILD_VERSION")
    /// 百度定位
    static let firstLocation = Key<Bool>("CX_FISRT_LOCATION_AUTHORIZATION")
    /// 首页推广接口
    static let promoteURL = Key<String>("promoteURL")
    /// 是否显示微信认证
    static let showWXAuth = Key<Bool>("showWXAuth")
    /// 用户地理位置经度
    static let userLatitude = Key<Double>("userLatitude")
    /// 用户地理位置维度
    static let userLongitude = Key<Double>("userLongitude")
    /// 微信认证商户ID
    static let wechatMerchantId = Key<String>("wechatMerchantId")
    /// 微信认证失败弹框是否已经展示
    static let isShowWechantAuthFail = Key<[String]>("isShowWechantAuthFail")
    

}

// MARK: - 多信宝
extension DefaultsKey {
    // 三方支付是否签约
    static let pay_signUp = Key<String>("pay_signUp")
    
    // 宝豆商城url
    static let dxb_mall_url = Key<String>("dxb_mall_url")
    
    // 首页功能列表
    static let dxb_functions = Key<String>("dxb_functions")
}
