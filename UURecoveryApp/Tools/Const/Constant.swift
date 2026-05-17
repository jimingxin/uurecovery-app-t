//
//  Constant.swift
//  CXMerchant
//
//  Created by zain guo on 2020/9/30.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

let g_disposeBag = DisposeBag()


let WH_APPID = "100082"
let WH_APPKEY = "17e19e85da475c146f3ed5b4fa532abe"
let WH_ADVANCE_ID = "1949"



struct Global {
    static let holderImage = UIImage(named: "gw_conteng_noimage")
    
    // 用于分页请求
    typealias RefreshParams = (isRefresh: Bool, showError: Bool )
    
    // 用于结果返回
    typealias ResultStatus = (status: Bool, msg: String)
}

// MARK: - IGListCell闭包
// 获取cell元类
typealias CellClassAction = (ListCollectionContext, Int, ListDiffable) -> AnyClass
// 获取section个数
typealias CellNumsAction = (ListCollectionContext, ListDiffable) -> Int
// 尺寸回调
typealias CellSizeAction = (ListCollectionContext, Int, ListDiffable) -> CGSize
// CellForItem 回调
typealias CellForItemAction = (ListCollectionContext, UICollectionViewCell, Int, ListDiffable) -> Void
// 点击回调
typealias CellDidSelectedAction = (ListCollectionContext, Int, ListDiffable) -> Void

// 通用的回调
typealias CompleteAction = (Any) -> Void

// MARK:  - 分割线

struct NotificationKey {

    // 查看通知详情
    static let CX_LOOK_NOTIFICATIONDETAIL_NOTI = "CX_LOOK_NOTIFICATIONDETAIL_NOTI"
    
}

struct ConstKeys {
    
    /// 发送短信验证码AES加密秘钥
    static let smsAESKey = "MERCHANT_SMS_KEY"
    
    // 发送短信加密key
    static let online_sms_aes_key = "DYONLINE_SMS_KEY"
    
    // 电银开卡绑卡加密key
    static let online_card_aes_key = "ON_LINE_CARD_KEY"
    
    // 支付宝支付需要的schemes
    static let schemes_aliPay = "dxbmerchantAliPay"
}



// MARK: - 显示Loading 和 隐藏Loading

/// 加载动画
/// - Parameters:
///   - v: 需要add的父视图
///   - msg: 需要显示的文字
func kLoading(v: UIView?, msg: String? = nil )  {
    
    guard let pv = v  else {
        return
    }
    
    if let str = msg {
        MBProgressHUD.yx_showActivityIndicator(to: pv, message: str)
    }else{
        MBProgressHUD.yx_showActivityIndicator(to: pv)
    }
}

/// Toast
/// - Parameter msg: 显示文字
/// - Returns:
func kMessage(msg: String) -> Void {
    MBProgressHUD.yx_showMessage(msg)
}

/// 隐藏
/// - Returns:
func kDismiss() -> Void {
    MBProgressHUD.yx_hudDismiss()
}


/// 倒计时
/// - Parameters:
///   - second: 倒计时的秒数
///   - immediately: 是否立即开始，true 时将立即开始倒计时，false 时将在 1 秒之后开始倒计时
///   - duration: 倒计时的过程
/// - Returns: 倒计时结束时的通知

func countdown(second: Int,
               immediately: Bool = true,
               duration: ((Int) -> Void)?) -> Single<Void> {
    
    guard second > 0 else {
        return Single<Void>.never()
    }

    if immediately {
        duration?(second)
    }
    return Observable<Int>
        .interval(.seconds(1), scheduler: MainScheduler.instance)
        .map { second - (immediately ? ($0 + 1) : $0) }
        .take(second + (immediately ? 0 : 1))
        .do(onNext: { (index) in
            duration?(index)
        })
        .filter { return $0 == 0 }
        .map { _ in return () }
        .asSingle()
 }
