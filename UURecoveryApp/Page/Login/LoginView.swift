//
//  LoginView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/23.
//

import UIKit
import DefaultsKit

class LoginView: BaseView {
    
    static let phone_app_store = "11111111111"
    // 验证码的长度
    let len_code = 4
    
    var target: UIViewController?
    
    fileprivate let v_root = UIView()
    fileprivate let v_continer = UIView()
    
    fileprivate let lab_title = UILabel.init(title: "登录", textColor: .color_333, fontSize: 13).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 22)
    }
    
    fileprivate let lab_hint = UILabel.init(title: "首次登录将自动注册", textColor: .color_888, fontSize: 15)
    
    fileprivate let tf_phone = UITextField.init().then { tf in
        tf.placeholder = "请输入手机号"
    }
    
    fileprivate let tf_code = UITextField.init().then { tf in
        tf.placeholder = "请输入验证码"
    }
    
    fileprivate let btn_send_code = UIButton.init(title: "获取", fontSize: 14, normalColor: .color_main).then { btn in
        btn.setTitleColor(.color_888, for: .disabled)
    }
    
    fileprivate let btn_action = UIButton.init(title: "注册/登录", fontSize: 14, normalColor: .white)
    
    fileprivate let btn_check = UIButton(type: .custom).then { btn in
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.setImage(UIImage(named: "rodio_unSel"), for: .normal)
        btn.setImage(UIImage(named: "rodio_sel"), for: .selected)
    }
    
    // 用户协议 和 隐私协议
    fileprivate let btn_privancy_user = UIButton.init(title: "《用户服务协议》", fontSize: 14, normalColor: .color_main)
    
    fileprivate let btn_privancy = UIButton.init(title: "《隐私协议》", fontSize: 14, normalColor: .color_main)
    
    override func baseAddSubViews() {
        addSubview(v_root)
        v_root.flex.direction(.row).justifyContent(.center).define { flex in
            flex.addItem(v_continer)
                .marginHorizontal(30)
                .cornerRadius(8)
                .marginTop(20%)
                .grow(1)
                .define { flex in
//                    flex.addItem(lab_title).marginTop(20)
                    let flex_iv = flex.addItem(UIImageView(imageName: "icon-phone"))
                        .width(60)
                        .height(60)
                        .cornerRadius(30)
                        .marginTop(20)
                        .marginLeft((Const.screenWidth - 120) / 2)
                    flex_iv.view?.clipsToBounds = true
                    flex.addItem(lab_hint).marginTop(20)
                    // 输入手机号
                    flex.addItem()
                        .height(55)
                        .marginTop(20)
                        .direction(.row)
                        .backgroundColor(.bg_color)
                        .cornerRadius(16)
                        .alignItems(.center)
                        .define { flex in
                            flex.addItem(tf_phone).height(100%).grow(1).marginHorizontal(Const.padding)
                        }
                    
                    flex.addItem()
                        .height(55)
                        .marginTop(20)
                        .direction(.row)
                        .backgroundColor(.bg_color)
                        .cornerRadius(16)
                        .alignItems(.center)
                        .define { flex in
                            flex.addItem(tf_code).height(100%).marginLeft(Const.padding).grow(1)
                            flex.addItem(btn_send_code).width(80).height(100%)
                        }
                    
                    // 提交登录
                    flex.addItem(btn_action).marginTop(30).height(50).cornerRadius(8)
                    
                    // 按钮同意和协议
                    flex.addItem().direction(.row).marginTop(10).define { flex in
                        flex.addItem(btn_check)
                        flex.addItem(UILabel(title: "同意", textColor: .color_333, fontSize: 15))
                        flex.addItem(btn_privancy_user)
                        flex.addItem(btn_privancy)
                    }
                }
        }
    }
    
    
    override func baseConfig() {
        tf_phone.keyboardType = .numberPad
        tf_code.keyboardType = .numberPad
        btn_check.isSelected = true
        // 手机号
        let rx_phone = tf_phone.rx.text.orEmpty.map {  [weak self] text in
            var str = text;
            if (text.count >= 11) {
                str = text.substring(start: 0, 11)
            }
            self?.tf_phone.text = str
            if str == LoginView.phone_app_store {
                self?.btn_send_code.isHidden = true
            } else {
                self?.btn_send_code.isHidden = false
            }
            return str.count == 11
        }.share(replay: 2)
        // 是否可用
        rx_phone.bind(to: btn_send_code.rx.isEnabled).disposed(by: disposeBag)
        
        let rx_code = tf_code.rx.text.orEmpty.map {[weak self] text in
            guard let self = self else {
                return false
            }
            var str = text;
            
            if (text.count >= len_code) {
                str = text.substring(start: 0, len_code)
            }
            self.tf_code.text = str
            return str.count == len_code
        }.share(replay: 1)
        
        // 是否同同时可以正常，按钮登录
        let rx_action = Observable.combineLatest(rx_phone, rx_code)
            .map({ phone, code in
                return phone && code
            })
            .share(replay: 1)
        
        rx_action.subscribe(onNext: { [weak self] isAble in
            if isAble {
                self?.btn_action.isEnabled = true
                self?.btn_action.backgroundColor = .color_main
            } else {
                self?.btn_action.isEnabled = false
                self?.btn_action.backgroundColor = .color_eee
            }
        }).disposed(by: disposeBag)
        
        // 点击事件 发送验证码
        btn_send_code.rx.tap.subscribe { [weak self] _ in
            self?.sendCode()
        }.disposed(by: disposeBag)
        
        btn_check.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {
                return
            }
            self.btn_check.isSelected = !self.btn_check.isSelected 
        }.disposed(by: disposeBag)
        
        // 注册登录
        btn_action.rx.tap.subscribe {[weak self] _ in
            //
            self?.checkVerificationCode()
        }.disposed(by: disposeBag)
        
        // 点击隐私协议
        btn_privancy_user.rx.tap.subscribe {[weak self] _ in
            self?.goToWeb(url: "\(API.baseURL)\(API.DataRecovery.userAgreement.rawValue)", title: "用户协议")
        }.disposed(by: disposeBag)
        
        btn_privancy.rx.tap.subscribe {[weak self] _ in
            self?.goToWeb(url: "\(API.baseURL)\(API.DataRecovery.privacyPolicy.rawValue)", title: "隐私协议")
        }.disposed(by: disposeBag)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 使用 pin 进行布局
        v_root.pin.all(safeAreaInsets)
        v_root.flex.layout()
        
        
    }
    
    /// 跳转到网页
    /// - Parameter url: url地址
    private func goToWeb(url: String, title:String = "Title") {
        let vc =  WebViewController()
        vc.str_url = url
        vc.backEnable = true
        vc.str_title = title
        target?.navigationController?.pushViewController(vc, animated: true)
    }
}


extension LoginView {
    
    /// 获取验证码
    fileprivate func sendCode(){
        
        guard let text = tf_phone.text, text.count  >  0 else {
            MBProgressHUD.yx_showMessage("请输入手机号")
            return
        }
        
        MBProgressHUD.yx_showLoding(withMessage: "获取验证码...")
        let params: [String:Any] = [
            "memberMobile": text,
            ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.sendVerificationCode.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Any.self
        ).subscribe( onSuccess: { [weak self] res in
            if res.status == "S" {
                // 倒计时
                self?.couontDownAction()
                MBProgressHUD.yx_showMessage("验证码发送成功")
            } else {
                MBProgressHUD.yx_showMessage("验证码发送失败")
            }
        }, onFailure: { _ in
            MBProgressHUD.yx_showMessage("验证码发送失败")
        }).disposed(by: disposeBag)
    }
    
    /// 校验验证码
    fileprivate func checkVerificationCode(){
        
        guard let phone = tf_phone.text, phone.count  >  0 else {
            MBProgressHUD.yx_showMessage( "手机号不能为空")
            return
        }
        
        guard let code = tf_code.text, code.count  >  0 else {
            MBProgressHUD.yx_showMessage("验证码不能为空")
            return
        }
        
        if !self.btn_check.isSelected {
            MBProgressHUD.yx_showMessage( "请先选择同意用户服务协议和隐私协议")
            return
        }
        self.btn_action.isEnabled = false
        MBProgressHUD.yx_showLoding(withMessage: "  登录中...  ")
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
            "memberMobile": phone,
            "verificationCode": code,
            ]
        
        let userInfo = Resp.LoginRespModel(nickname: "",
                                           memberName: "", 
                                           memberMobile: phone,
                                           mobileId: GlobalModel.getDeviceID()
        )
        Network.request(
            method: .POST,
            path: API.DataRecovery.checkVerificationCode.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Resp.LoginRespModel.self
        ).flatMapModel(Resp.LoginRespModel.self)
        .subscribe( onSuccess: { [weak self] res in
            MBProgressHUD.yx_hudDismiss()
            userDefaults.set(userInfo, for: MXDefaultKey.userInfo)
            userDefaults.set(true, for: MXDefaultKey.isLogin)
            MBProgressHUD.yx_showMessage("登录成功")
            self?.btn_action.isEnabled = true
            Asyncs.delay(2) {
                self?.target?.navigationController?.popViewController(animated: true)
            }
            if GlobalModel.sdkOnOff == "Y" {
                // 上报注册事件
                BDASignalManager.trackEssentialEvent(withName: kBDADSignalSDKEventRegister, params: [:])
            }
        }, onFailure: {[weak self] err in
            self?.btn_action.isEnabled = true
            MBProgressHUD.yx_hudDismiss()
            guard let error = err as? Network.Error else { return  }
            MBProgressHUD.yx_showMessage(error.message)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func couontDownAction() {
        countdown(second: 60) { [weak self] count in
            if count <= 0 {
                self?.btn_send_code.isEnabled = true
                self?.btn_send_code.setTitle("获取", for: .normal)
            } else {
                self?.btn_send_code.isEnabled = false
                self?.btn_send_code.setTitle("\(count)秒", for: .normal)
            }
        }.subscribe { _ in }.disposed(by: disposeBag)
    }
}

