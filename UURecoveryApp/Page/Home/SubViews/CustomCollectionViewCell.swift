//
//  CustomCollectionViewCell.swift
//  Example for ZCycleView
//
//  Created by bigPro on 2021/3/12.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    lazy var imageView = UIImageView()
    
    lazy var lab_price = UILabel(title: "168", textColor: .hex("#B68A6D"), blodSize: 28)
    
    let str_desc  = GlobalModel.str_zhuangjia
    
    let str_desc_normal = GlobalModel.str_normal
    
    lazy var lab_desc = UILabel(title: str_desc, textColor: .hex("#B68A6D"), fontSize: 9).then { lab in
        lab.numberOfLines = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        imageView.frame = contentView.bounds
        contentView.addSubview(imageView)
        contentView.addSubview(lab_price)
        contentView.addSubview(lab_desc)
        
        lab_price.snp.makeConstraints { make in
            make.leading.equalTo(6)
            make.top.equalTo(contentView.snp.centerY).offset(-20)
        }
        
        lab_desc.snp.makeConstraints { make in
            make.leading.equalTo(lab_price.snp.leading)
            make.top.equalTo(lab_price.snp.bottom).offset(0)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 根据数据源配置数据
    /// - Parameters:
    ///   - item: 模型数据
    ///   - isNormal: 是否普通版
    func configData(item: Resp.ProductModel, isNormal: Bool = false) {
        if isNormal {
            lab_price.textColor = .hex("#2E79CF")
            lab_desc.textColor = .hex("#2E79CF")
            lab_price.text = String(format: "%.2f", item.normalPrice.toDouble() ?? 128.00)
            lab_desc.text = str_desc_normal
        }else {
            
            lab_price.textColor = .hex("#B68A6D")
            lab_desc.textColor = .hex("#B68A6D")
            lab_price.text = String(format: "%.2f", item.expertPrice.toDouble() ?? 168.00)
            lab_desc.text = str_desc
        }
    }
}
