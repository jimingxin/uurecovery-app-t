//
//  BaseCellProtocol.swift
//  CXMerchant
//
//  Created by zain guo on 2020/12/11.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation

public protocol BaseCellProtocol {
    
    associatedtype Model
    func setModel(_ model: Model?, indexPath: IndexPath?)
}

