//
//  WeakMallScriptMessageDelegate.swift
//  DXBMerchant
//
//  Created by 嵇明新 on 2021/12/29.
//  Copyright © 2021 jimingxin. All rights reserved.
//

import UIKit
import WebKit

class WeakMallScriptMessageDelegate: NSObject {
    //MARK:- 属性设置
        private weak var scriptDelegate: WKScriptMessageHandler!
        
        //MARK:- 初始化
        init(scriptDelegate: WKScriptMessageHandler) {
            self.scriptDelegate = scriptDelegate
        }

}

extension WeakMallScriptMessageDelegate: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            self.scriptDelegate.userContentController(userContentController, didReceive: message)
        }

}
