//
//  HomeNoticeCollectionViewCell.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/4/16.
//

import UIKit

class HomeNoticeCollectionViewCell: BaseCollectionViewCell {
    
    lazy var v_point = UIView()
    
    lazy var iv_noti = UIImageView(imageName: "home_notice")
    
    lazy var lab_tip = UILabel.init(title: "最新消息", textColor: .color_333, blodSize: 12)
    
    lazy var lab_desc = UILabel.init(title: "", textColor: .color_666, fontSize: 12)
    
    lazy var lab_service = UILabel.init(title: "", textColor: .hex("#698FF4"), fontSize: 12)
    
    lazy var lab_time = UILabel.init(title: "", textColor: .color_999, blodSize: 12)
    
    override func baseAddSubViews() {
//        contentView.addSubview(v_point)
        contentView.addSubview(iv_noti)
        contentView.addSubview(lab_tip)
        contentView.addSubview(lab_service)
        contentView.addSubview(lab_desc)
        contentView.addSubview(lab_time)
    }
    
    override func baseAddConstraints() {
        
        iv_noti.snp.makeConstraints { make in
            make.leading.equalTo(-5)
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.centerY.equalToSuperview()
        }
        
        lab_tip.snp.makeConstraints { make in
            make.leading.equalTo(iv_noti.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        lab_desc.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lab_desc.snp.makeConstraints { make in
            make.leading.equalTo(lab_tip.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        lab_service.snp.makeConstraints { make in
            make.leading.equalTo(lab_desc.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        }
        
        lab_time.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        v_point.clearVisual.conrnerRadius(radius: 5).conrnerCorner(corner: .allCorners).showVisual
    }
    
}
