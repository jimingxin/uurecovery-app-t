//
//  KeFuListSectionItemCell.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/8/19.
//

import UIKit

class KeFuListSectionItemCell: BaseCollectionViewCell,BaseCollectionProtocol {
    
    
    typealias ItemModel = Resp.CmrItemModel
    
    let arr_icon = ["kefu00","kefu01","kefu02","kefu03","kefu04"]
    
    lazy var iv_con = UIView()
    lazy var iv_icon = UIImageView()
    lazy var lab_title = UILabel(title: "Title", textColor: .color_333, fontSize: 16)
    lazy var lab_desc = UILabel(title: "Desc", textColor: .color_999, fontSize: 14)
    lazy var iv_arrow = UIImageView(imageName: "arrow_right")
    
    override func baseAddSubViews() {
    
        iv_con.backgroundColor = .white
        contentView.addSubview(iv_con)
        iv_icon.backgroundColor = UIColor.random
        iv_con.addSubview(iv_icon)
        iv_con.addSubview(lab_title)
        iv_con.addSubview(lab_desc)
        iv_con.addSubview(iv_arrow)
    }
    
    override func baseAddConstraints() {
        iv_con.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        iv_icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(Const.padding)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        lab_title.snp.makeConstraints { make in
            make.leading.equalTo(iv_icon.snp.trailing).offset(Const.padding)
            make.top.equalTo(iv_icon.snp.top)
            make.trailing.equalToSuperview().offset(-Const.padding * 2)
        }
        
        lab_desc.snp.makeConstraints { make in
            make.leading.equalTo(iv_icon.snp.trailing).offset(Const.padding)
            make.top.equalTo(lab_title.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-Const.padding * 2)
        }
        
        iv_arrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Const.padding)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        }
        
    }
    
    
    func setItemModel(_ model: Resp.CmrItemModel?, index: Int) {
        guard let mod = model else { return  }
        
//        iv_icon.kf.setImage(mod.crmImgUrl)
        if let imgurl = arr_icon.get(at: index) {
            iv_icon.image = UIImage(named: imgurl)
        }
        lab_title.text = mod.crmName
        lab_desc.text = mod.crmDesc
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iv_con.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 8).showVisual
        iv_icon.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 30).showVisual
    }
}
