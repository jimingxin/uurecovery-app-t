//
//  NavigationBarView.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/8/26.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

private struct Constants {
//    static let screenWidth = UIScreen.main.bounds.width
//    static let screenHeight = UIScreen.main.bounds.height
    static let navBarHeight: CGFloat = 44
    static let tabBarHeight: CGFloat = 49
    static let itemHeight: CGFloat = 40
    static let itemWidth: CGFloat = 45
//    static var statusBarHeight: CGFloat {
////        guard isIphoneX else {
////            return 20
////        }
////        if #available(iOS 14.0, *) {
////            return 48
////        } else {
////            return 44
////        }
//        guard UI_USER_INTERFACE_IDIOM() == .phone else { return 0 }
//        guard #available(iOS 11.0, *) else { return 0}
//        guard let window = UIApplication.shared.windows.first else { return 0 }
//        return window.safeAreaInsets.top
//    }
//    static var safeAreaHeight: CGFloat {
//        guard UI_USER_INTERFACE_IDIOM() == .phone else { return 0 }
//        guard #available(iOS 11.0, *) else { return 0}
//        guard let window = UIApplication.shared.windows.first else { return 0 }
//        return window.safeAreaInsets.bottom
//    }
//    /// 是否是iphoneX
//    static var isIphoneX: Bool {
//        
//        guard UI_USER_INTERFACE_IDIOM() == .phone else { return false }
//        guard #available(iOS 11.0, *) else { return false}
//        guard let window = UIApplication.shared.windows.first else { return false }
//        let isX = window.safeAreaInsets.bottom > 0
//        return isX
//    }
}

public class NavigationBarView: UIView {
    /// 设置导航title
    public var title: String? {
        didSet {
            self.titleBtn.setTitle(title, for: .normal)
        }
    }
    /// 设置标题颜色
    public var titleColor: UIColor? {
        didSet {
            self.titleBtn.setTitleColor(titleColor, for: .normal)
        }
    }
    /// 设置返回按钮图片
    public var leftImage: String? {
        didSet {
            if let name = leftImage {
                self.leftItem.setImage(UIImage(named: name), for: .normal)
            }
        }
    }
    /// 设置右按钮图片
    public var rightImage: String? {
        didSet {
            if let name = rightImage {
                self.rightItem.setImage(UIImage(named: name), for: .normal)
            }
        }
    }
    /// 设置右按钮标题
    public var rightTitle: String? {
        didSet {
            rightItem.setTitle(rightTitle, for: .normal)
        }
    }
    
    public var allBackgroundColor: UIColor? {
        didSet {
            backgroundColor = allBackgroundColor
        }
    }
    
    public var statusBackgroundColor: UIColor?{
        didSet {
            statusView.backgroundColor = statusBackgroundColor;
        }
    }
    
    public var navBackgroundColor: UIColor?{
        didSet {
            navigationBar.backgroundColor = navBackgroundColor;
        }
    }
 
    
    // MARK: - 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: Const.screenWidth, height: Const.statusBarHeight + Const.realNavBarHeight)
        addSubview(statusView)
        navigationBar.addSubview(bottomLine)
        navigationBar.bringSubviewToFront(bottomLine)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 懒加载
    // 状态栏
    public lazy var statusView: UIView = {
        let statusView = UIView(frame: CGRect(x: 0, y: 0, width: Const.screenWidth, height: Const.statusBarHeight))
        statusView.backgroundColor = UIColor.clear
        return statusView
    }()
    // 导航视图
    public lazy var navigationBar: UIView = {
         let barView = UIView(frame: CGRect(x: 0, y: Const.statusBarHeight, width: Const.screenWidth, height: Const.realNavBarHeight))
        barView.backgroundColor = UIColor.clear
        barView.layer.masksToBounds = true
        addSubview(barView)
        return barView
    }()
    /// 背景图片
    public lazy var backgroundImageView: UIImageView = {
        let bgImageView = UIImageView(frame: self.bounds)
        bgImageView.contentMode = ContentMode.scaleAspectFill
        addSubview(bgImageView)
        sendSubviewToBack(bgImageView)
        return bgImageView
    }()
    /// 返回按钮
    public lazy var leftItem: UIButton = {
        let lefItem = UIButton(type: .custom)
        lefItem.adjustsImageWhenHighlighted = false
        lefItem.frame = CGRect(x: 0, y: (Const.realNavBarHeight - Constants.itemHeight)/2.0, width: Constants.itemWidth, height: Constants.itemHeight)
        lefItem.imageEdgeInsets = UIEdgeInsets.zero
        lefItem.addTarget(self, action: #selector(leftItemAction), for: .touchUpInside)
        
        if let count = self.parentController?.navigationController?.viewControllers.count,
           count > 1 {
            lefItem.setImage(UIImage(named: "common_icon_bg_color"), for: .normal)
        }
        self.navigationBar.addSubview(lefItem)
        return lefItem
    }()
    /// 右按钮
    public lazy var rightItem: UIButton = {
        let rightItem = UIButton(type: .custom)
        rightItem.adjustsImageWhenHighlighted = false
        rightItem.frame = CGRect(x: Const.screenWidth - Constants.itemWidth, y: (Const.realNavBarHeight - Constants.itemHeight)/2.0, width: Constants.itemWidth, height: Constants.itemHeight)
        rightItem.imageEdgeInsets = UIEdgeInsets.zero
        rightItem.setTitleColor(.hex("333333"), for: .normal)
        rightItem.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightItem.contentHorizontalAlignment = .left
        self.navigationBar.addSubview(rightItem)
        return rightItem
    }()
    /// 用来自定义视图
    public lazy var titleView: UIView = {
        let titleView = UIView(frame: CGRect(x: Constants.itemWidth + 5, y: 0, width: Const.screenWidth - Constants.itemWidth * 2 - 10, height: Const.realNavBarHeight))
        self.navigationBar.addSubview(titleView)
        return titleView
    }()
    /// 标题button
    public lazy var titleBtn: UIButton = {
        let titleBtn = UIButton(type: .custom)
        titleBtn.titleLabel?.font = UIFont.cx.pingfangMedium(ofSize: 17)
        titleBtn.titleLabel?.numberOfLines = 1
        titleBtn.backgroundColor = UIColor.clear
        titleBtn.setTitleColor(.hex("333333"), for: .normal)
        titleBtn.adjustsImageWhenHighlighted = false
        titleBtn.isUserInteractionEnabled = false
        titleBtn.frame = CGRect(x: self.leftItem.frame.maxX + 5, y: 0, width: Const.screenWidth - Constants.itemWidth * 2 - 10, height: self.navigationBar.bounds.height)
        titleBtn.contentHorizontalAlignment = .center
        self.navigationBar.addSubview(titleBtn)
        return titleBtn
    }()
    /// 底部线条
    public lazy var bottomLine: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: self.navigationBar.frame.maxY, width: Const.screenWidth, height: 0.5))
        line.backgroundColor = UIColor.clear
        return line
    }()
}

extension NavigationBarView {
    // MARK: - 返回按钮事件
    @objc func leftItemAction() {
        self.parentController?.navigationController?.popViewController(animated: true)
    }
    /// 移除返回按钮点击事件
    public func removeLeftItemAction() {
        self.leftItem.removeTarget(self, action: #selector(leftItemAction), for: .touchUpInside)
    }
}


