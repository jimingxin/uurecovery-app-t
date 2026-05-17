//
//  ServiceItemCollectionViewCell.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/21.
//

import UIKit

class ServiceItemCollectionViewCell: BaseCollectionViewCell,BaseCollectionProtocol {
   
    
    typealias ItemModel = Resp.OrderRespModel
    
    
    let str_desc  = """
    1.专家一对一服务，无需自己操作
    2.长期有效服务，不限使用时间，随时可恢复
    3.优先安排高级专家恢复，无需排队，需要即用
    """
    
    let str_desc_normal = """
    1.排队恢复，30分钟内安排恢复
    2.普通工程师一对一操作
    3.下单后一年内可使用（有效期一年）
    """
    
    lazy var v_root = UIView().then { v in
        v.backgroundColor = .white
    }
    // 订单号
    lazy var lab_no = UILabel.init(title: "订单编号：20251108141953361196", textColor: .color_666, fontSize: 13)
    // 订单状态
    lazy var lab_status = UILabel.init(title: "订单状态", textColor: .red, fontSize: 14)
    
    // 复制图标
    lazy var iv_icon = UIImageView(imageName: "icon_copy")
    
    
    lazy var v_line  = UIView().then { v in
        v.backgroundColor = .hex("#F5F5F5")
    }
    
    // 服务种类
    lazy var lab_type = UILabel.init(title: "服务类型", textColor: .white, blodSize: 12).then { lab in
        lab.textAlignment = .center
        lab.backgroundColor = .color_main
    }
    // 标题
    lazy var lab_title = UILabel.init(title: "聊天记录恢复", textColor: .color_333, fontSize: 14)
    
    
    // 服务类型
    lazy var lab_serve = UILabel.init(title: "服务内容", textColor: .white, blodSize: 12).then { lab in
        lab.textAlignment = .center
        lab.backgroundColor = .hex("#09B745")
    }

    lazy var lab_content = UILabel(title: str_desc, textColor: .color_666, fontSize: 14).then { lab in
        lab.numberOfLines = 0
    }

    
    lazy var lab_gj = UILabel(title: "共计", textColor: .color_333, fontSize: 13)
    
    // 金额
    lazy var lab_money = UILabel.init(title: "￥188.00", textColor: .color_333, fontSize: 16).then { lab in
        lab.font = Const.pingFang_SemiboldFont375(font: 16)
    }
    // 时间
    lazy var lab_date = UILabel(title: "2025-02-22 15:23", textColor: .hex("#9AA8C5"), fontSize: 12)
    
    
    // 按钮
    // 取消订单
    lazy var btn_cancel = UIButton.init(title: "取消订单", fontSize: 14, normalColor: .hex("#333333")).then { btn in
        btn.backgroundColor = .hex("#F2F2F5")
        btn.titleLabel?.font = Const.pingfang_MediumFont375(font: 14)
    }
    // 立即支付
    lazy var btn_action = UIButton.init(title: "去支付", fontSize: 14, normalColor: .white).then { btn in
        btn.backgroundColor = UIColor.color_main
        btn.titleLabel?.font = Const.pingfang_MediumFont375(font: 14)
    }
    // 上传联系方式
    lazy var btn_link = UIButton.init(title: "上传联系方式", fontSize: 14, normalColor: .hex("#979797")).then { btn in
        btn.backgroundColor = .hex("#F2F2F5")
        btn.titleLabel?.font = Const.pingfang_MediumFont375(font: 14)
    }
    
    

    override func baseAddSubViews() {
        contentView.addSubview(v_root)
        v_root.addSubview(lab_no)
        v_root.addSubview(lab_status)
        v_root.addSubview(iv_icon)
        
        v_root.addSubview(v_line)
        
        v_root.addSubview(lab_type)
        v_root.addSubview(lab_title)
       
        v_root.addSubview(lab_serve)
        v_root.addSubview(lab_content)
       
        v_root.addSubview(lab_gj)
        v_root.addSubview(lab_money)
        v_root.addSubview(lab_date)
        v_root.addSubview(btn_cancel)
        v_root.addSubview(btn_action)
        
        v_root.addSubview(btn_link)
    }
    
    override func baseAddConstraints() {
        
        v_root.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        lab_no.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
        }
        
        lab_status.snp.makeConstraints { make in
            make.centerY.equalTo(lab_no.snp.centerY)
            make.trailing.equalTo(-10)
        }
        iv_icon.snp.makeConstraints { make in
            make.leading.equalTo(lab_no.snp.trailing).offset(2)
            make.centerY.equalTo(lab_no.snp.centerY)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        v_line.snp.makeConstraints { make in
            make.leading.equalTo(Const.padding)
            make.trailing.equalTo(-Const.padding)
            make.top.equalTo(lab_no.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
        
        lab_type.snp.makeConstraints { make in
            make.top.equalTo(v_line.snp.top).offset(8)
            make.width.equalTo(56)
            make.height.equalTo(20)
            make.leading.equalTo(lab_no.snp.leading)
        }
        lab_title.snp.makeConstraints { make in
            make.centerY.equalTo(lab_type.snp.centerY)
            make.leading.equalTo(lab_type.snp.trailing).offset(5)
        }
    
        lab_money.snp.makeConstraints { make in
            make.centerY.equalTo(lab_title.snp.centerY)
            make.trailing.equalTo(lab_status.snp.trailing)
        }
        
        lab_serve.snp.makeConstraints { make in
            make.top.equalTo(lab_title.snp.bottom).offset(8)
            make.width.equalTo(56)
            make.height.equalTo(20)
            make.leading.equalTo(lab_no.snp.leading)
        }
        lab_content.snp.makeConstraints { make in
            make.leading.equalTo(lab_title.snp.leading)
            make.trailing.equalTo(-Const.padding)
            make.top.equalTo(lab_title.snp.bottom).offset(12)
        }
        
        lab_date.snp.makeConstraints { make in
            make.leading.equalTo(lab_no.snp.leading)
            make.centerY.equalTo(btn_action.snp.centerY).priority(.medium)
            make.centerY.equalTo(btn_cancel.snp.centerY).priority(.low)
        }
        
//        lab_gj.snp.makeConstraints { make in
//            make.leading.equalTo(lab_no.snp.leading)
//            make.bottom.equalTo(lab_date.snp.top).offset(-2)
//        }
    
        btn_action.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.trailing.equalTo(-10)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        btn_cancel.snp.makeConstraints { make in
            make.centerY.equalTo(btn_action.snp.centerY)
            make.width.equalTo(btn_action.snp.width)
            make.height.equalTo(btn_action.snp.height)
            make.trailing.equalTo(btn_action.snp.leading).offset(-10)
        }
        
        btn_link.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.trailing.equalTo(-10)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    override func baseConfig() {
        iv_icon.isUserInteractionEnabled = true;
        iv_icon.cx.addTapGesture(target: self, action: #selector(copyAction))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 6).showVisual
        btn_action.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 15).showVisual
        
        btn_cancel.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 15).showVisual

        btn_link.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 15).showVisual

//        btn_cancel.clearVisual.borderColor(color: .hex("#979797")).borderWidth(width: 1).conrnerCorner(corner: .allCorners).conrnerRadius(radius: 15).showVisual
//        
//        btn_link.clearVisual.borderColor(color: .hex("#979797")).borderWidth(width: 1).conrnerCorner(corner: .allCorners).conrnerRadius(radius: 15).showVisual
        lab_type.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 4).showVisual
        lab_serve.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 4).showVisual
    }
    
    
    /**
     复制操作
     */
    @objc func copyAction() {
        UIPasteboard.general.string = lab_no.text;
        MBProgressHUD.yx_showMessage("复制成功")
    }
    
    func setItemModel(_ model: ItemModel?, index: Int) {
        
        guard let mod = model else {
            return
        }
        
        lab_no.text = "订单编号:\(mod.orderNo)"
        lab_status.text = mod.orderStatusText
        lab_title.text = mod.productName
        if mod.serviceType == "EXPERT" {
            lab_content.text = str_desc
        } else {
            lab_content.text = str_desc_normal
        }
        lab_date.text = mod.creationDate
        lab_money.text = "￥\(mod.orderAmount)"
        btn_link.isHidden = true
        
        // 隐藏取消和支付按钮
        if mod.orderStatus == ServiceItemController.PageType.COMPLETED.rawValue ||
            mod.orderStatus == ServiceItemController.PageType.PAID.rawValue ||
            mod.orderStatus == ServiceItemController.PageType.CANCELLED.rawValue {
    
            btn_cancel.isHidden = true
            btn_action.isHidden = true
            if mod.orderStatus == ServiceItemController.PageType.PAID.rawValue,
               mod.memberMobile.count == 0 {
                btn_link.isHidden = false
            }
        } else {
            btn_cancel.isHidden = false
            btn_action.isHidden = false
        }
    }
    
}
