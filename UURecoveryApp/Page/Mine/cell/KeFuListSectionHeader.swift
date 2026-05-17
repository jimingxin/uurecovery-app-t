//
//  KeFuListSectionHeader.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/8/19.
//

import UIKit

class KeFuListSectionHeader: UICollectionReusableView, BaseViewConfig {

    lazy var iv_header = UIImageView(imageName: "cmr_header").then { iv in
        iv.contentMode = .scaleAspectFill
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseConfig()
        baseAddSubViews()
        baseAddConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func baseAddSubViews() {
        addSubview(iv_header)
    }
    
    func baseAddConstraints() {
        iv_header.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func baseConfig() {
        
    }

}
