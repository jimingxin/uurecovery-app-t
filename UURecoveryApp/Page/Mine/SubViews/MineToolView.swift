//
//  MineToolView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/22.
//

import UIKit

class MineToolView: BaseView {
    
    weak var target:UIViewController?
    
    lazy var v_root = UIView()
    
    lazy var isShowAll = false
    
    var arr_mod = ["用户协议","隐私协议","关于我们","设备信息","版本号","注销账号"]
    var arr_img = ["mine_tool_user", "mine_tool_privacy","mine_tool_about", "mine_tool_device","mine_version","mine_out"]
    
    override func baseAddSubViews() {
        if Tools.checkUpdate() == false { // 非审核状态
            isShowAll = true
            self.arr_mod.insert("我要投诉", at: 0)
            self.arr_img.insert("mine_tool_ts", at: 0)
        }
        
        addSubview(v_root)
        v_root.backgroundColor = .white
        addRootView()
        
    
    }
    
    override func baseAddConstraints() {
        self.snp.makeConstraints { make in
            make.bottom.equalTo(v_root.snp.bottom).offset(10)
        }
    }
    
    override func baseConfig() {
        GlobalModel.sub_refresh.subscribe(onNext: {[weak self] refresh in
            if refresh{
                self?.arr_mod.insert("我要投诉", at: 0)
                self?.arr_img.insert("mine_tool_ts", at: 0)
                self?.addRootView()
            }
        }).disposed(by: g_disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.top().left().right()
        v_root.flex.layout(mode: .adjustHeight)
        
    }
    
    fileprivate func addRootView() {
        removeAllSubviews(from: v_root)
        v_root.flex.direction(.column).marginHorizontal(10)
            .cornerRadius(8)
            .define { flex in
                // 工具栏
                var index = 0;
                arr_mod.forEach { mod in
                    let temp = flex.addItem()
                        .marginLeft(20)
                        .marginRight(10)
                        .direction(.row)
                        .justifyContent(.spaceBetween)
                        .alignItems(.center)
                        .minHeight(50)
                        .define { flex in
                            flex.addItem().grow(1).direction(.row).define { flex in
                                let iv = UIImageView(imageName: arr_img.get(at: index)!)
                                let lab = UILabel.init(title: mod, textColor: .color_333, fontSize: 15)
                                flex.addItem(iv).width(22).height(22)
                                flex.addItem(lab).marginLeft(10).marginRight(10)
                            }
                            flex.addItem()
                                .grow(1)
                                .direction(.row)
                                .justifyContent(.end)
                                .alignItems(.center)
                                .define { flex in
                                    
                                    addToolRightDesc(flex: flex, index: index)
                                    let iv = UIImageView(imageName: "mine_tool_arrow")
                                    flex.addItem(iv).width(8).height(12).marginRight(2)
                                    
                                }
                        }
                    temp.view?.tag = index + 100;
                    index += 1
                    temp.view?.cx.addTapGesture(target: self, action: #selector(toolAction(ges:)))
                    flex.addItem().backgroundColor(.color_e9).height(0.5).marginLeft(Const.padding)
                }
            }
        v_root.flex.markDirty()
    }
    
    fileprivate func addToolRightDesc(flex: Flex, index: Int) {
        if Tools.checkUpdate() {
            if index == 3 {
                let device_name = Tools.getDeviceName()
                flex.addItem(UILabel(title: device_name, textColor: .hex("#9AA8C5"), fontSize: 12))
                    .marginRight(8)
            } else if (index == 4) {
                let version = Tools.appVersion() ?? ""
                flex.addItem(UILabel(title: version, textColor: .hex("#9AA8C5"), fontSize: 12))
                    .marginRight(8)
            }
        } else {
            if index == 4 {
                let device_name = Tools.getDeviceName()
                flex.addItem(UILabel(title: device_name, textColor: .hex("#9AA8C5"), fontSize: 12))
                    .marginRight(8)
            } else if (index == 5) {
                let version = Tools.appVersion() ?? ""
                flex.addItem(UILabel(title: version, textColor: .hex("#9AA8C5"), fontSize: 12))
                    .marginRight(8)
            }
        }
        
    }
    
    @objc fileprivate func toolAction(ges: UITapGestureRecognizer){
        
        let index = (ges.view?.tag ?? 100) - 100;
        let mod = arr_mod.get(at: index)
        
        if Tools.checkUpdate() {
            if index == 0 {
                // 用户协议
                goToWeb(url: "\(API.baseURL)\(API.DataRecovery.userAgreement.rawValue)", title: "用户协议")
            }else if index == 1 {
                // 隐私协议
                goToWeb(url: "\(API.baseURL)\(API.DataRecovery.privacyPolicy.rawValue)", title: "隐私政策")
                
            }else if index == 2 {
                let vc_about = AboutViewController()
                target?.navigationController?.pushViewController(vc_about, animated: true)
            } else if (index == 5) {
                guard let user = userDefaults.get(for: MXDefaultKey.userInfo),
                      user.memberMobile.count > 0 else {
                    MBProgressHUD.yx_showMessage("您未登录")
                    return
                }
                AlertView.showAlert(title: "提示",
                                    message: "是否注销账号并删除数据?",
                                    leftItemTitle: "取消",
                                    rightItemTitle: "确认") { _ in
                    
                } rightItemBlock: {[weak self] _ in
                    // 注销账号
                    self?.logOffUser()
                }

                
            }
        } else {
            if index == 0 {
                // 我要投诉
                let vc = ComplaintViewController()
                vc.str_title = mod ?? "我要投诉"
                self.target?.navigationController?.pushViewController(vc, animated: true)
            }else if index == 1 {
                // 用户协议
                goToWeb(url: "\(API.baseURL)\(API.DataRecovery.userAgreement.rawValue)", title: "用户协议")
            }else if index == 2 {
                // 隐私协议
                goToWeb(url: "\(API.baseURL)\(API.DataRecovery.privacyPolicy.rawValue)", title: "隐私政策")
                
            }else if index == 3 {
                let vc_about = AboutViewController()
                target?.navigationController?.pushViewController(vc_about, animated: true)
            } else if (index == 6) {
                guard let user = userDefaults.get(for: MXDefaultKey.userInfo),
                      user.memberMobile.count > 0 else {
                    MBProgressHUD.yx_showMessage("您未登录")
                    return
                }
                AlertView.showAlert(title: "提示",
                                    message: "是否注销账号并删除数据?",
                                    leftItemTitle: "取消",
                                    rightItemTitle: "确认") { _ in
                    
                } rightItemBlock: {[weak self] _ in
                    // 注销账号
                    self?.logOffUser()
                }

                
            }
        }
        
        
    }
    
    
    /// 条转到网页
    /// - Parameter url: url地址
    private func goToWeb(url: String, title:String = "Title") {
        let vc =  WebViewController()
        vc.str_url = url
        vc.backEnable = true
        vc.str_title = title
        target?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func logOffUser(){
        
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
        ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.logOffMember.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Any.self
        )
        .subscribe( onSuccess: {[weak self] res in
            if res.status == "S" {
                guard let vc = self?.target as? MineViewController else { return  }
                let _ = GlobalModel.delDeviceID()
                vc.refreshUserInfo(isLogout: true)
                MBProgressHUD.yx_showMessage("账号注销成功")
            } else {
                MBProgressHUD.yx_showMessage("账号注销失败")
            }
        }, onFailure: { _ in
            MBProgressHUD.yx_showMessage("账号注销失败")
        }).disposed(by: disposeBag)
        
        
    }
    
    
    fileprivate func removeAllSubviews(from view: UIView){
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
}
