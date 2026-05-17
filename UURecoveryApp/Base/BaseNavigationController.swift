//
//  BaseNavigationController.swift
//  CXSwiftCommonModule_Example
//
//  Created by tineco on 2025/2/13.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit


class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true;
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 { // 非根视图隐藏底部的 tabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if viewControllers.count > 1 {
            topViewController?.hidesBottomBarWhenPushed = false;
        }
        
        let controllers = super.popToRootViewController(animated: animated);
        return controllers;
    }

}

