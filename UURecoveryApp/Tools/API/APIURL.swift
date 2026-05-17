//
//  ApiURL.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/9.
//  Copyright © 2020 canshi. All rights reserved.
//

import CoreFoundation

public struct API {
    /// 定义基础域名
    public static var baseURL: String {
#if TestSever
        return "https://www.youyou0112.com"
//        return "http://1.94.60.235:8080"
#else
//        return "http://1.94.60.235:8080"
//        return "https://2jv3sv029369.vicp.fun"
        return "https://www.uu0112.com"
        
#endif
    }
    
    public static var h5Host: String {
#if TestSever
        return "https://2jv3sv029369.vicp.fun"
#else
        return "https://2jv3sv029369.vicp.fun"
#endif
    }
    
    
    /// 数据恢复
    enum DataRecovery: String {
        // 查询有效商品列表
        case findAllProductList = "/uuServer/msProductInfo/findAllProductList"
        // 查询用户订单列表
        case findUserOrderList = "/uuServer/msOrderInfo/findUserOrderList"
        // 查询问题列表
        case findAllQuestionList = "/uuServer/msQuestionInfo/findAllQuestionList"
        // 创建订单
        case getAlipayOrderStr = "/uuServer/msOrderInfo/getAlipayOrderStr"
        // 取消订单
        case cancelOrder = "/uuServer/msOrderInfo/cancelOrder"
        // 添加订单联系信息
        case addOrderContact = "/uuServer/msOrderInfo/addOrderContact"
        // 用户协议
        case userAgreement = "/uuServer/static/document/user_agreement.html"
        // 隐私协议
        case privacyPolicy = "/uuServer/static/document/privacy_policy.html"
        // 关于我们
        case aboutUs = "/uuServer/stati c/document/about_us.html"
        // 发送验证码
        case sendVerificationCode = "/uuServer/msMemberInfo/sendVerificationCode"
        // 校验验证码
        case checkVerificationCode = "/uuServer/msMemberInfo/checkVerificationCode"
        // 客服
        case keFu = "https://tb.53kf.com/code/client/af1735b9ea1f914b928dd315ff76bb077/1"
        // 上报激活
        case activeApp = "/uuServer/msOceanengineInfo/activeApp"
        // 获取版本号
        case findVersion = "/uuServer/msMemberInfo/findVersion"
        // 注销账号
        case logOffMember = "/uuServer/msMemberInfo/logOffMember"
        // 查询sdk开关
        case findSdkOnOff = "/uuServer/msMemberInfo/findSdkOnOff"
        // 获取所有的客服
        case findAllCrmList = "/uuServer/msCrmInfo/findAllCrmList"
    }
    
    enum HomeApi: String {
        
        /// Get 获取商户结算详情
        case get_settleDetail = "/openapi/merchant/settle/getSettleDetail"
        
    }
}

// MARK: - 通用的工具接口
extension API {
    enum Unit: String {
        /// 图片上传
        case uploadImage = "/openapi/merchant/common/images"
    }
}
