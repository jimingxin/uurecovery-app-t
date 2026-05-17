//
//  ServerDetailViewController.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/8.
//

import UIKit

class ServerDetailViewController: BaseViewController {
    
    struct CompareModel {
        var title: String = ""
        var time: String = ""
        var enginer: String = ""
        var validity: String = ""
        var color: UIColor = .color_333
        var bold: Bool = true
        var bgColor: UIColor = .color_e5
    }
    
    let arr_title = [
        CompareModel(title: "服务类型", time: "响应时间", enginer: "工程师", validity: "有效期",bgColor: .hex("#FFFBF8")),
        CompareModel(title: "普通检测", time: "1小时内", enginer: "实习工程师", validity: "3天", color: .color_666, bold: false, bgColor: .hex("#F9FBFF")),
        CompareModel(title: "专家检查", time: "5分钟内", enginer: "高级工程师", validity: "一年", color: .hex("#FF544E"), bgColor: .hex("#FFF8F0"))
    ]
    
    var item: Resp.ProductModel?
    
    // 用于滚动
    fileprivate let contentView = UIScrollView().then { sv in
        sv.showsVerticalScrollIndicator = false
    }
    
    lazy var index_cur = 1
    
    // 主容器
    lazy var v_root = UIView()
    
    // 标题
    lazy var str_title = "服务"
    
    // 倒计时组件
    lazy var v_time = ServerTimerView()
    
    // 选择套餐
//    lazy var v_select = ServerSelectView().then { sv in
//        sv.callBack = { [weak self] index in
//            self?.index_cur = index
//        }
//    }
    
    lazy var v_order_select = ServerOrderSelectView().then { sv in
        sv.callBack = { [weak self] index in
            self?.index_cur = index
            self?.setMoneyText()
        }
    }
    
    // 技术费说明视图
    lazy var v_tech_fee = UIView().then { v in
//        v.backgroundColor = .hex("#FFF8F0")
    }
    
    // 流程
    lazy var v_flow = ServerFlowView()
    
    // 常见问题
    lazy var v_question = ServerQuestionView().then {[weak self] sv in
        
        sv.callBack = { _ in
            self?.v_comment.v_root.flex.markDirty()
            self?.view.setNeedsLayout()
        }
    }
    
    // 我们的评价
    lazy var v_comment = ServerCommentView()
    
    // 温馨提示
    lazy var v_tip = ServerTipsView()
    
    lazy var v_bottom = UIView().then { v in
        v.backgroundColor = .white
    }
    
    lazy var btn_pay = UIButton.init(title: "支付宝支付", fontSize: 16, normalColor: .white).then { btn in
        btn.backgroundColor = .hex("#265DF4")
    }
    
    lazy var lab_money = UILabel.init(title: "0", textColor: .white, blodSize: 24)
    lazy var lab_hint = UILabel.init(title: "元/年", textColor: .white, blodSize: 13)
    lazy var im_right = UIImageView(imageName: "server_bottom")
    lazy var lab_pay = UILabel.init(title: "立即购买", textColor: .color_333, blodSize: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        v_root.backgroundColor = .hex("#F8F8F8")
        contentView.delegate = self
        // 配置导航栏
        configNavBar()
        v_order_select.item = item
        
        setMoneyText()
        
    }
    
    override func baseAddSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(v_root)
        view.addSubview(v_bottom)
        v_bottom.addSubview(btn_pay)
        v_bottom.addSubview(lab_money)
        v_bottom.addSubview(lab_hint)
        v_bottom.addSubview(im_right)
        v_bottom.addSubview(lab_pay)
        
        // 技术费说明视图子视图
        let techFeeLabel = UILabel(title: "※因数据恢复技术难度大成本高，数据恢复成功后，需收取一次性技术费298元", textColor: .hex("#FF544E"), fontSize: 12)
        techFeeLabel.numberOfLines = 0
        v_tech_fee.addSubview(techFeeLabel)
        
        techFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.centerY.equalToSuperview()
        }
        
        v_root.flex
            .direction(.column).define { flex in
                flex.addItem(UIImageView(imageName: "Ser_bg"))
                    .position(.absolute)
                    .top(Const.statusBarHeight == 20 ? -44 : -(Const.realNavBarHeight))
                    .width(Const.screenWidth)
                    .aspectRatio(1.2)
                
                // 用于占位
                flex.addItem()
                    .marginTop(Const.screenWidth * 0.832 - Const.statusBarHeight  - 10)
                    .width(100%)
                    .height(1)
                // 时间倒计时
                flex.addItem(v_time).width(100%)
                // 选择套餐
                flex.addItem(v_order_select).margin(10).height(Const.adaptHeight(80))
                // 技术费说明（根据版本判断是否显示）
                if Tools.checkUpdate() {
                    flex.addItem(v_tech_fee).marginLeft(10).marginRight(10).marginTop(0).height(40)
                }
                // 方案对比
                addCompareView(flex: flex)
                // 添加支付宝支付
                addAliPayView(flex: flex)
                // 服务流程
                flex.addItem(v_flow).marginLeft(10).marginRight(10).height(130)
                // 常见问题
                flex.addItem(v_question).marginLeft(10).marginRight(10).marginTop(10)
                // 我梦的评价
                flex.addItem(v_comment).marginLeft(10).marginRight(10).marginTop(10)
                // 温馨提示
                flex.addItem(v_tip).marginLeft(10).marginRight(10).marginTop(10)
            }
    }
    
    
    override func baseAddConstraints() {
        
        v_bottom.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Const.statusBarHeight <= 20 ? 80: 100)
        }
        
        btn_pay.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(48)
            make.top.equalTo(16)
        }
        
        lab_money.snp.makeConstraints { make in
            make.leading.equalTo(btn_pay.snp.leading).offset(30)
            make.centerY.equalTo(btn_pay.snp.centerY)
        }
        
        lab_hint.snp.makeConstraints { make in
            make.leading.equalTo(lab_money.snp.trailing)
            make.centerY.equalTo(btn_pay.snp.centerY)
        }
        
        im_right.snp.makeConstraints { make in
            make.centerY.equalTo(btn_pay.snp.centerY)
            make.trailing.equalTo(btn_pay.snp.trailing).offset(1)
            make.height.equalTo(btn_pay.snp.height)
            make.width.equalTo(130)
        }
        
        lab_pay.snp.makeConstraints { make in
            make.center.equalTo(im_right.snp.center)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.pin.all()
        
        v_root.pin.top(Const.realNavBarHeight).left().right()
        // 使用 flex 进行适配
        v_root.flex.layout(mode: .adjustHeight)
        
        // UIScrollView 进行大小适配
        contentView.contentSize = CGSize(width: v_root.frame.size.width, height: v_root.frame.size.height + Const.safeAreaHeight * 2);
        contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Const.statusBarHeight <= 20 ? 130: 80, right: 0)
        
        
        if btn_pay.cx.width > 0 {
            btn_pay.cx.setGradientBackgroundColors([.hex("#2672FF"),.hex("#01348E")], direction: .gradientToRight)
            btn_pay.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 24).showVisual
        }
    }
    
    override func bindViewModel() {
        // 唤起支付按钮
        btn_pay.rx.tap.bind {[weak self] _ in
            self?.createOrder()
        }.disposed(by: disposeBag)
    }
    
    private func setMoneyText() {
        if index_cur == 0 {
            lab_money.text = item?.normalPrice ?? "0"
        } else if index_cur == 1 {
            lab_money.text = item?.expertPrice ?? "0"
        }
    }
    
    private func addAliPayView(flex: Flex) {
        flex.addItem()
            .direction(.row)
            .justifyContent(.spaceBetween)
            .alignItems(.center)
            .backgroundColor(.white)
            .marginHorizontal(10)
            .marginBottom(10)
            .height(54)
            .paddingHorizontal(10)
            .cornerRadius(16)
            .define { flex in
                flex.addItem().direction(.row).define { flex in
                    flex.addItem(UIImageView(imageName: "server_alipay"))
                        .width(20)
                        .height(20)
                        .marginRight(5)
                    flex.addItem(UILabel(title: "支付宝", textColor: .color_333, blodSize: 14))
                }
                flex.addItem(UIImageView(imageName: "server_radio"))
            }
    }
    
    private func addCompareView(flex: Flex) {
        
        let flex = flex.addItem()
            .direction(.column)
            .marginHorizontal(10)
            .marginVertical(10)
            .cornerRadius(16)
            .backgroundColor(.white)
            .define { flex in
                flex.addItem(UILabel(title: "恢复服务权益对比", textColor: .color_333, blodSize: 16))
                    .marginLeft(10)
                    .marginVertical(16)
                flex.addItem().direction(.row)
                    .marginTop(10)
                    .define { flex in
                        for index in 0..<arr_title.count {
                            let mod = arr_title[index]
                            flex.addItem()
                                .direction(.column)
                                .alignItems(.center)
                                .grow(1)
                                .backgroundColor(mod.bgColor)
                                .define { flex in
                                    flex.addItem(UILabel(title: mod.title, textColor: mod.color, blodSize: 14)).minHeight(40)
                                    flex.addItem(UILabel(title: mod.time, textColor: mod.color, blodSize: 14)).minHeight(40)
                                    flex.addItem(UILabel(title: mod.enginer, textColor: mod.color, blodSize: 14)).minHeight(40)
                                    flex.addItem(UILabel(title: mod.validity, textColor: mod.color, blodSize: 14)).minHeight(40)
                                }
                        }
                    }
            }
        flex.view?.clipsToBounds = true
    }
    
    
}

extension ServerDetailViewController {
    
    fileprivate func configNavBar() {
        
        let type = GlobalModel.ProductType(rawValue: item?.productType ?? "")
        cx.navigationBar?.title = type?.desc ?? str_title
        cx.navigationBar?.allBackgroundColor = .clear
        cx.navigationBar?.titleColor = .white
        cx.navigationBar?.leftImage = "back_white"
    }
    
    /**
     调用网络生成订单
     */
    fileprivate func createOrder() {
        
        guard let it =  self.item else {
            MBProgressHUD.yx_showMessage("产品信息为空")
            return
        }
        MBProgressHUD.yx_showLoding(withMessage: "生成订单...")
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
            "memberMobile": GlobalModel.getLoginPhone(),
            "productType": it.productType,
            "serviceType": index_cur == 1 ?  "EXPERT" : "NORMAL"
        ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.getAlipayOrderStr.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Resp.CreateOrderRespModel.self
        ).flatMapModel(Resp.CreateOrderRespModel.self)
        .subscribe( onSuccess: { [weak self] res in
            MBProgressHUD.yx_hudDismiss()
            self?.openAliapyAction(mod: res)
        }, onFailure: { _ in
            MBProgressHUD.yx_hudDismiss()
        }).disposed(by: disposeBag)
    }
    
    /**
     唤起支付宝支付
     */
    fileprivate func openAliapyAction(mod: Resp.CreateOrderRespModel) {
        
        if mod.orderNo.count > 0 {
            // 储存订单号
            userDefaults.set(mod.orderNo, for: MXDefaultKey.yy_order_no_paid)
        }
        
        AliPayManager.shared.payAlertController(self,
                                                request: mod.alipayOrderStr) { [weak self] in
            
            // 通知页面进行刷新
            GlobalModel.sub_refresh_order.onNext(true)
            // 清空订单号
            userDefaults.set("", for: MXDefaultKey.yy_order_no_paid)
            if GlobalModel.sdkOnOff == "Y" {
                // 上报金额
                BDASignalManager.trackEssentialEvent(withName: kBDADSignalSDKEventPurchase,
                                                     params:["pay_amount": (mod.orderAmount.toInt() ?? 0) * 100])
            }
            
            if let user = userDefaults.get(for: MXDefaultKey.userInfo),
                user.memberMobile.count > 0 {
                //
                MBProgressHUD.yx_showMessage("支付成功，请到订单页面刷新查看")
            } else {
                //
                
                AlertPopupView.showInputView { phone, name in
                    self?.addOrderContact(phone: phone, name: name, mod: mod)
                } close: {
                    MBProgressHUD.yx_showMessage("稍后请再订单列表添加联系方式")
                }

            }
        } payFail: {
            // 清空订单号
            userDefaults.set("", for: MXDefaultKey.yy_order_no_paid)
            // 通知页面进行刷新- 订单
            GlobalModel.sub_refresh_order.onNext(true)
            MBProgressHUD.yx_showMessage("支付取消，请确认")
        }

    }
    
    
    /// 绑定用户信息
    /// - Parameters:
    ///   - phone: 手机号
    ///   - name: 用户名
    ///   - mod: 订单信息
    fileprivate func addOrderContact(phone: String, name: String, mod: Resp.CreateOrderRespModel) {
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
            "orderNo": mod.orderNo,
            "contactPhone": phone,
            "contactName": name
        ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.addOrderContact.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Any.self
        )
        .subscribe( onSuccess: { res in
            if res.status == "S" {
                MBProgressHUD.yx_showMessage("绑定成功，请到订单页面查看")
            } else {
                MBProgressHUD.yx_showMessage("绑定失败，请联系客服")
            }
        }, onFailure: { _ in
            MBProgressHUD.yx_showMessage("绑定失败，请联系客服")
        }).disposed(by: disposeBag)
    }
    
}

/**
 scroll的回调代理
 */
extension ServerDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y > 64 {
//            cx.navigationBar?.allBackgroundColor = .white
//            cx.navigationBar?.titleColor = .color_333
//            cx.navigationBar?.leftImage = "common_icon_bg_color"
//        } else {
//            cx.navigationBar?.allBackgroundColor = .clear
//            cx.navigationBar?.titleColor = .white
//            cx.navigationBar?.leftImage = "back_white"
//        }
//        
        if scrollView.contentOffset.y > 64 {
            UIView.animate(withDuration: 0.3) {
                self.cx.navigationBar?.allBackgroundColor = .white
                self.cx.navigationBar?.titleColor = .color_333
                self.cx.navigationBar?.leftImage = "common_icon_bg_color"
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.cx.navigationBar?.allBackgroundColor = .clear
                self.cx.navigationBar?.titleColor = .white
                self.cx.navigationBar?.leftImage = "back_white"
            }
        }
    }
    

}
