import Foundation

extension String {
  var localized: String { return NSLocalizedString(self, comment: self) }
/*
  Localizable.strings
  CXMerchant

  Created by zainguo on 2020/7/30.
  Copyright © 2020 zainguo. All rights reserved.
*/

  static var localized_帮助中心: String { return "帮助中心".localized }
  static var localized_常见问题: String { return "常见问题".localized }
  static var localized_关于多信宝: String { return "关于多信宝".localized }
  static var localized_指定银行: String { return "指定银行".localized }
  static var localized_bind_specify_bankcard: String { return "    您已经绑定指定银行卡，是否开启自动提现，开启自动提现后提现免手续费。".localized }
  static var localized_no_bind_specify_bankcard: String { return "    您尚未绑定指定银行卡，是否申请办理指定银行卡，成功绑定后自动提现免手续费。".localized }
  static var localized_confirm_aply_specify_bank: String { return "    是否确认办理%@的储蓄卡，确认后会将您的基本信息授权给银行，届时会有工作人员与您联系。".localized }
  static var localized_open_bind_card: String { return "    您有50000元的免费手动提现额度待领取(绑定%@卡)".localized }
  static var localized_wait_bank_accept: String { return "等待银行受理中".localized }
  static var localized_mine_feed_back: String { return "请详细描述你所遇到的问题，不少于10个字".localized }
  static var localized_mine_feed_back_tip: String { return "意见反馈内容不能为空".localized }
  static var localized_date_picker_start: String { return "选择开始时间".localized }
  static var localized_date_picker_end: String { return "选择结束时间".localized }
  static var localized_lable_time_start: String { return "开始时间".localized }
  static var localized_lable_time_end: String { return "结束时间".localized }
  static var localized_lable_time_between: String { return "选择区间（支持近30天内数据查询）".localized }
  static var localized_search: String { return "查询".localized }
  static var localized_lab_hint_no_data: String { return "当前暂无数据记录".localized }
  static var localized_lab_trade_year_desc: String { return "仅保留近1年数据".localized }
  static var localized_lab_title_trade_moon: String { return "月交易统计".localized }
  static var localized_lab_select_date: String { return "选择日期".localized }
  static var localized_lab_submit_confirm: String { return "是否确认提交?".localized }
  static var localized_lab_cancel: String { return "取消".localized }
  static var localized_lab_confirm: String { return "确认".localized }
  static var localized_lab_question_sucess: String { return "意见反馈成功".localized }
  static var localized_lab_trade_year_hint: String { return "仅可查看近一年的数据".localized }
  static var localized_lab_btn_custom_search: String { return "自定义查询".localized }
  static var localized_lab_vc_title_Incomme: String { return "今日收入".localized }
  static var localized_lab_today_Incomme_selected_start: String { return "请选择开始时间".localized }
  static var localized_lab_today_Incomme_selected_end: String { return "请选择结束时间".localized }
  static var localized_lab_today_section_title_income: String { return "收款统计".localized }
  static var localized_lab_today_section_title_outlay: String { return "支出统计".localized }
  static var localized_lab_today_section_title_user: String { return "用户统计".localized }
  static var localized_alert_register_hint: String { return "当前法人已经注册过多信宝账号，请核实好商户信息再申请。".localized }
  static var localized_alert_register_back_hint: String { return "是否离开当前页面".localized }
  static var localized_lab_feedback_less: String { return "请最少输入10个字符".localized }

  static var localized_str_json_decode_error: String { return "数据解析错误".localized }

/// ================ 钱包 ================
  static var localized_wallet_title: String { return "钱包".localized }
  static var localized_wallet_balance_detail: String { return "余额明细".localized }
  static var localized_wallet_manual_withdrwal: String { return "手动提现".localized }
  static var localized_wallet_auto_withdrwal: String { return "自动提现".localized }
  static var localized_wallet_frozen_amount: String { return "冻结金额".localized }
  static var localized_wallet_withdrwal_record: String { return "结算记录".localized }
  static var localized_wallet_apply_withdrwal_amount: String { return "申请提现免审额度".localized }

/// ================ 我的 ================
  static var localized_me_bankcard: String { return "我的银行卡".localized }
  static var localized_me_withdrwal_detail: String { return "提现记录".localized }
  static var localized_me_transfer_money: String { return "转账".localized }
  static var localized_me_scan: String { return "扫一扫".localized }
  static var localized_me_free_setup: String { return "免单劵设置".localized }
  static var localized_me_device_manager: String { return "设备管理".localized }
  static var localized_me_register: String { return "入驻申请".localized }
  static var localized_me_identifier_auth: String { return "微信认证".localized }
  static var localized_me_spending_settings: String { return "消费金设置".localized }
  static var localized_me_identifier_credit: String { return "我的抵用金".localized }
  static var localized_me_invite_code: String { return "我的邀请码".localized }
  static var localized_me_my_integral: String { return "我的积分".localized }
  static var localized_me_my_caifen: String { return "我的菜粉".localized }
  static var localized_me_user_manager: String { return "用户管理".localized }
  static var localized_me_promotion_code: String { return "我的推广码".localized }

  static var localized_me_service_center: String { return "客服中心".localized }
  static var localized_me_help_center: String { return "帮助中心".localized }
  static var localized_me_user_policy: String { return "用户协议".localized }
  static var localized_me_spread: String { return "推广".localized }
  static var localized_me_nor_career: String { return "多信宝生涯".localized }
  static var localized_me_third_protocol: String { return "三方协议".localized }
  static var localized_me_raiders: String { return "攻略".localized }
  static var localized_me_cloud_policy: String { return "云店服务协议".localized }
  static var localized_me_set: String { return "设置".localized }


/// ================ 登录 ================

  static var localized_lab_phone_placeholder: String { return "请输入您的手机号".localized }
  static var localized_lab_password_placeholder: String { return "请输入您的密码".localized }
  static var localized_lab_phone_code_placeholder: String { return "请输入验证码".localized }
  static var localized_lab_login_title: String { return "多信宝".localized }
  static var localized_lab_login_subtitle: String { return "助力线下门店业绩倍增".localized }
  static var localized_lab_login_forgetPswd: String { return "忘记密码".localized }
  static var localized_lab_login_code_login: String { return "验证码登录".localized }
  static var localized_lab_login_pswd_login: String { return "密码登录".localized }
  static var localized_lab_login: String { return "登录".localized }
  static var localized_lab_login_applay_merchant: String { return "商户入驻申请".localized }
  static var localized_lab_login_privacy_policy: String { return "《多信宝隐私政策》".localized }
  static var localized_lab_user_policy: String { return "《多信宝用户及入驻协议》".localized }
/// ================ 首页 ================
  static var localized_lab_receive_payment: String { return "收款".localized }
/// ================ 云店钱包 ================


/// ================ 云店 ================
  static var localized_lab_recharge: String { return "充值".localized }
  static var localized_lab_cloudshop_recharge: String { return "提现".localized }
  static var localized_lab_cloud_wallet: String { return "云店钱包".localized }
  static var localized_lab_cloud_title: String { return "云店".localized }
  static var localized_lab_cloud_trade_list: String { return "交易记录".localized }
  static var localized_lab_count_hint: String { return "自动统计数量已去重".localized }
  static var localized_lab_red_default_title: String { return "恭喜发财,大吉大利".localized }
  static var localized_str_pwd_not_set: String { return "您还未设置支付密码，请前往设置".localized }
  static var localized_str_go_to_set: String { return "去设置".localized }
  static var localized_str_insufficient_balance: String { return "余额不足".localized }
  static var localized_str_go_to_recharge: String { return "去充值".localized }
  static var localized_str_please_input_phone: String { return "请输入手机号查询".localized }
  static var localized_str_discount_manager: String { return "折扣卡管理".localized }

}
