//
//  RouterTargetType.swift
//  Demo
//
//  Created by zain guo on 2020/9/15.
//  Copyright © 2020 zain guo. All rights reserved.
//


import UIKit

public protocol RouterTargetType { }

public protocol RouterSourceType {
    var viewController: UIViewController? { get }
}

public protocol MediatorType {
    func viewController(of target: RouterTargetType) -> UIViewController?
}


