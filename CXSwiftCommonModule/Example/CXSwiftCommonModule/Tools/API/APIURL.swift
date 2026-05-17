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
        return "https://test-dxb-platform-backend.duoxinbao.net"
#else
        return "https://dxb-platform-backend.duoxinbao.net"
#endif
    }
    
    public static var h5Host: String {
#if TestSever
        return "https://test-dxb-h5.duoxinbao.net"
#else
        return "https://dxb-h5.duoxinbao.net"
#endif
    }
    
    
    enum HomeApi: String {
        
        /// POST 获取商户年检状态
        case annual_check_status = "/openapi/merchant/personInfo/getStatusForYeahCheck"
        /// POST 提交商户年检状态
        case add_merchant_annual_check = "/openapi/merchant/personInfo/addMerchantPhotoForYeahCheck"
        /// 提交电银用户协议
        case uptMerchantProtocolFlag = "/openapi/merchant/base/uptMerchantProtocolFlag"
        /// 安心签签署状态查询
        case check_getAxqInfo = "/openapi/merchant/base/getAxqInfo"
        /// POST  安心签拒绝须知弹框
        case axq_refuseAlert = "/openapi/merchant/base/getAxqInfoRefuse"
        /// POST 安心签重签
        case axq_resign = "/openapi/merchant/base/getAxqInfoReissue"
        /// GET 获取商城登录的URL
        case mall_url = "/openapi/merchant/mall/getLoginUrl"
        /// GET 获取待结算信息
        case get_unSettled_amount = "/openapi/merchant/settle/getPendingSettleInfo"
        /// POST 每月商户结算信息
        case get_listSettleInfo = "/openapi/merchant/settle/listSettleInfo"
        /// Get 获取商户结算详情
        case get_settleDetail = "/openapi/merchant/settle/getSettleDetail"
        
    }
}

// MARK: - 通用的工具接口
extension API {
    enum Unit: String {
        /// 图片上传
        case uploadImage = "/openapi/merchant/common/images"
        /// OCR识别 1银行卡 2身份证人像面 3营业执照 4身份证国徽
        case imgOCR = "/openapi/merchant/common/imageOcr"
        /// OCR识别 1银行卡 2身份证人像面 3营业执照 4身份证国徽
        case backIdCardOCR = "/openapi/merchant/common/imageOcr1"
        /// 身份证正面面OCR识别
        case frontIdCardOCR = "/openapi/merchant/base/idCardOcr"
        /// 查询享利金弹框状态 POST
        case enjoyKingStatus = "/openapi/merchant/base/getMerchantEnjoyKingStatus"
        /// 设置享利金弹框/积分弹框记录 POST
        case saveIntegralStatus = "/openapi/merchant/base/saveMerchantIntegralMsgStatus"
    }
}
