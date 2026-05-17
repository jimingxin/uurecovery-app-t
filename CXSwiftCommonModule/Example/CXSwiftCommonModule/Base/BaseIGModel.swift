//
//  BaseIGModel.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/10/14.
//  Copyright © 2020 zainguo. All rights reserved.
//
//  IGList用于基类

import UIKit

public class BaseIGModel: NSObject, ListDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? NSObject else {
            return false
        }
        return object == self
    }
}
