//
//  MineViewController.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/18.
//

import UIKit
import DefaultsKit

class MineViewController: BaseViewController {
    
    lazy var v_bg = UIImageView(imageName: "mine_bg")
    
    fileprivate let contentView = UIScrollView().then { sv in
        sv.showsVerticalScrollIndicator = false
    }
    
    lazy var v_root = UIView()
    
    lazy var height_content:CGFloat = 0
    
    lazy var v_login = MineLoginView().then { login in
        login.target = self
    }
    
    lazy var v_order = MineOrderView().then { order in
        order.target = self
    }
    
    lazy var v_tool = MineToolView().then { mv in
        mv.target = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = userDefaults.get(for: MXDefaultKey.userInfo),
              user.memberMobile.count > 0 else {
            v_login.isUserInteractionEnabled = true
            return
        }
        
        v_login.isUserInteractionEnabled = false
        v_login.lab_name.text = user.memberName.count > 0 ? user.memberName : user.memberMobile
        v_login.lab_desc.isHidden = true
    }
    
    override func baseAddSubViews() {
        view.addSubview(v_bg)
        view.addSubview(v_root)
        contentView.addSubview(v_root)
        self.view.addSubview(contentView)
        v_root.addSubview(v_login)
        v_root.addSubview(v_order)
        v_root.addSubview(v_tool)
    }
    
    override func baseAddConstraints() {
        v_bg.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Const.screenWidth * 0.752)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        v_root.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(Const.screenWidth)
            make.bottom.equalToSuperview().offset(-Const.bottomTabBarHeight)
        }
        
        v_login.snp.makeConstraints { make in
            make.top.equalTo( Const.navBarHeight - 20 )
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(200)
        }
        
        v_order.snp.makeConstraints { make in
            make.top.equalTo(v_login.snp.bottom).offset(-40)
            make.leading.trailing.equalTo(0)
        }
        
        v_tool.snp.makeConstraints { make in
            make.top.equalTo(v_order.snp.bottom).offset(Const.padding)
            make.leading.trailing.equalTo(0)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        v_bg.cx.setGradientBackgroundColors(
//            [UIColor.color_main, .color_main.withAlphaComponent(0.5), .bg_color],
//            direction: .gradientToBottom)
//        if v_root.cx.height > 0 {
//            if height_content < v_root.cx.height {
//                height_content = v_root.cx.height
//            }
//            contentView.contentSize = CGSize(width: Const.screenWidth, height: height_content)
//        }
        
    
    }
    
    
    /// 是否退出
    /// - Parameter isLogout: true 退出登录
    func refreshUserInfo(isLogout: Bool){
        // 通知刷新
        GlobalModel.sub_refresh_order.onNext(true)
        let user = Resp.LoginRespModel()
        userDefaults.set(user, for: MXDefaultKey.userInfo)
        
        v_login.isUserInteractionEnabled = true
        
        v_login.lab_desc.isHidden = false
        v_login.lab_name.text = "点击登录/注册"
        v_login.lab_desc.text = "您还未登录/注册"
    }

}
