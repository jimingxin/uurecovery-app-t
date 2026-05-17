//
//  MineLoginView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/22.
//

import UIKit

class MineLoginView: BaseView {
    
    weak var target:UIViewController?

    lazy var iv_logo = UIImageView(imageName: "mine_user").then { iv in
        iv.backgroundColor = .color_main
    }
    
    lazy var lab_name = UILabel.init(title: "点击登录/注册", textColor: .color_333, fontSize: 18).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 18)
    }
    
    lazy var lab_desc = UILabel.init(title: "开启UU数据守护之旅", textColor: .color_666, fontSize: 14)
    
    override func baseAddSubViews() {
        addSubview(iv_logo)
        addSubview(lab_name)
        addSubview(lab_desc)
    }
    
    override func baseAddConstraints() {
        iv_logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.centerY.equalToSuperview().offset(-50)
        }
        
        lab_name.snp.makeConstraints { make in
            make.centerX.equalTo(iv_logo.snp.centerX)
            make.top.equalTo(iv_logo.snp.bottom).offset(8)
        }
        
        lab_desc.snp.makeConstraints { make in
            make.centerX.equalTo(iv_logo.snp.centerX)
            make.top.equalTo(lab_name.snp.bottom).offset(5)
        }
    }
    
    override func baseConfig() {
        cx.addTapGesture(target: self, action: #selector(tapAction))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iv_logo.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 30).showVisual
        self.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 10).showVisual
    }
    
    @objc func tapAction() {
        if self.lab_desc.isHidden {
            return
        }
        let login = LoginViewController()
        target?.navigationController?.pushViewController(login, animated: true)
    }

}
