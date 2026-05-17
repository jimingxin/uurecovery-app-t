//
//  BaseCollectionViewCell.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/8/26.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

public protocol BaseCollectionProtocol {
    
    associatedtype ItemModel
    func setItemModel(_ model: ItemModel?, index: Int)
}

@objcMembers
class BaseCollectionViewCell: UICollectionViewCell {

    var disposeBag = DisposeBag()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseAddSubViews()
        baseAddConstraints()
        baseConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        baseAddSubViews()
        baseAddConstraints()
        baseConfig()
    }

    deinit {
        Const.log("==============释放了\(type(of: self))==============\n")
    }

}

extension BaseCollectionViewCell: BaseViewConfig {
    
    func baseAddSubViews() { }

    func baseAddConstraints() { }

    func baseConfig() { }

}

