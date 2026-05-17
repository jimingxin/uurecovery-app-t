//
//  BaseViewController.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/9.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

@objcMembers public class BaseViewController: UIViewController, UIGestureRecognizerDelegate {


    let disposeBag = DisposeBag()


    /// 是否允许侧滑
    public var fullScreenPopGestureEnabled: Bool = true {
        didSet {
            if navigationController?.responds(to: NSSelectorFromString("interactivePopGestureRecognizer")) == true {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = fullScreenPopGestureEnabled
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .bg_color
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        baseAddSubViews()
        configNavigationBar()
        baseAddConstraints()

        baseConfig()
        bindViewModel()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
          return .default
      }


    deinit {
        Const.log("==============😭😭😭释放了\(type(of: self))==============\n")
    }
    
}


extension BaseViewController: BaseControllerConfig {
    
    public func baseAddSubViews() { }
    
    public func baseAddConstraints() { }
    
    public func baseConfig() { }
    
    public func configNavigationBar() { }
    
    public func bindViewModel() { }
    
    
}
