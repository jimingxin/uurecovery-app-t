//
//  Flex-Ex.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/3/10.
//

import FlexLayout

extension Flex {
    /// 是否进行布局计算及显示
    public var isLayoutAndShow: Bool {
        set {
            isIncludedInLayout = newValue
            self.view?.isHidden = !newValue
        }
        get {
            return isIncludedInLayout && (self.view?.isHidden ?? false)
        }
    }
}
