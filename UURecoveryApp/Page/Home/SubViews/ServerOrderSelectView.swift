//
//  ServerOrderSelectView.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/6/21.
//

import UIKit

class ServerOrderSelectView: BaseView {
    
    enum OrderImageBg : String{
        case normal = "order_normal_unsel"
        case normalSel = "order_normal_sel"
        case professional = "order_per_unsel"
        case professionalSel = "order_per_sel"
    }
    
    typealias ServerCallBack = (Int) -> Void
    
    var callBack: ServerCallBack?
    
    var item: Resp.ProductModel? = .none {
        didSet {
            setMoney()
        }
    }
    
    lazy var v_root = UIView();
    
    lazy var bg_left = UIImageView(imageName: OrderImageBg.normal.rawValue)
    lazy var lab_left_top = UILabel.init(title: "128.00元/年", textColor: .color_7a, fontSize: 16)
    lazy var lab_left_bottom = UILabel.init(title: "普通检测", textColor: .color_7a, fontSize: 16)
    lazy var v_left = UIView()
    
    lazy var bg_right = UIImageView(imageName: OrderImageBg.professionalSel.rawValue)
    lazy var lab_right_top = UILabel.init(title: "188.00元/年", textColor: .color_333, fontSize: 16)
    lazy var lab_right_bottom = UILabel.init(title: "专家检测", textColor: .color_333, fontSize: 16)
    lazy var v_right = UIView();
    
    override func baseAddSubViews() {
        
        addSubview(v_root)
        
        v_root.flex
            .direction(.row)
            .justifyContent(.center)
            .marginLeft(5)
            .define { flex in
                flex.addItem(v_left).grow(1)
                    .direction(.column)
                    .grow(1)
                    .height(Const.adaptHeight(80))
                    .paddingLeft(10)
                    .justifyContent(.center)
                    .define { flex in
                        flex.addItem(bg_left)
                            .width(100%).height(100%).position(.absolute)
                        flex.addItem(lab_left_top)
                        flex.addItem(lab_left_bottom)
                        
                    }
                
                flex.addItem(v_right).grow(1)
                    .direction(.column)
                    .grow(1)
                    .paddingLeft(10)
                    .justifyContent(.center)
                    .height(Const.adaptHeight(80))
                    .define { flex in
                        flex.addItem(bg_right).width(100%).height(100%).position(.absolute)
                        flex.addItem(lab_right_top)
                        flex.addItem(lab_right_bottom)
                        
                    }
            }
    }
    
    override func baseConfig() {
        
        v_left.cx.addTapGesture(target: self, action: #selector(btnAction(sender:)))
        v_right.cx.addTapGesture(target: self, action: #selector(btnAction(sender: )))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        v_root.pin.all()
        v_root.flex.layout(mode: .adjustHeight)
    }
    
    private func setMoney() {
        guard let temp = item else {
            lab_left_top.text = "0.00元/年"
            lab_right_top.text = "0.00元/年"
            return
        }
        lab_left_top.text = "\(temp.normalPrice)元/年"
        lab_right_top.text = "\(temp.expertPrice)元/年"
        
    }
    
    @objc private func btnAction(sender: UITapGestureRecognizer) {
        if sender.view == v_left {
            lab_left_top.text = "\(item?.normalPrice ?? "128.00")元/年"
            lab_left_top.textColor = .color_333
            lab_left_bottom.textColor = .color_333
            lab_right_top.textColor = .color_7a
            lab_right_bottom.textColor = .color_7a
            bg_left.image = UIImage(named: OrderImageBg.normalSel.rawValue)
            bg_right.image = UIImage(named: OrderImageBg.professional.rawValue)
            if let cb = callBack {
                cb(0)
            }
        } else if sender.view == v_right{
            lab_right_top.text = "\(item?.expertPrice ?? "188.00")元/年"
            lab_right_top.textColor = .color_333
            lab_right_bottom.textColor = .color_333

            lab_left_top.textColor = .color_7a
            lab_left_bottom.textColor = .color_7a
            bg_right.image = UIImage(named: OrderImageBg.professionalSel.rawValue)
            bg_left.image = UIImage(named: OrderImageBg.normal.rawValue)
            if let cb = callBack {
                cb(1)
            }
        }
        
        bg_left.alpha = 0
        bg_right.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.bg_left.alpha = 1
            self.bg_right.alpha = 1
        }
        
    }
}
