//
//  AlertPopupView.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/16.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit

// 完成回调
typealias AlertPopupCompletion = ()->()

class AlertPopupView: UIView {
    
    // 所有的弹框内容视图
    static var containerArray:[AlertPopupView] = []
    
    
    enum AnimationType: Int {
        case fadeInOut
        case zoomInOut
    }

    deinit {
        debugPrint("==============😭😭😭释放了\(type(of: self))==============😭😭😭")
    }
    unowned let containerView: UIView
    unowned let contentView: UIView
    public let backgroundView: UIControl
    private var animationStyle = AnimationType.fadeInOut
    /*
     - isInteractive  为YES时，可以触发contentView上的交互操作
     - isDismissable  为YES时，点击背景区域可以消失（前提是isPenetrable == false）
     - isPenetrable   为YES时，将会忽略背景区域的交互操作
     */
    public var isInteractive = true
    public var isPenetrable = false
    public var isDismissable = false {
        didSet {
            backgroundView.isUserInteractionEnabled = isDismissable
        }
    }

    public var isAnimating = false

    public init(containerView: UIView, contentView: UIView) {
        
        self.containerView = containerView
        self.contentView = contentView
        backgroundView = UIControl(frame: containerView.bounds)
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        backgroundView.isUserInteractionEnabled = isDismissable
        
        super.init(frame: containerView.bounds)
        
        backgroundView.addTarget(self, action: #selector(backgroundViewClicked), for: .touchUpInside)
        addSubview(backgroundView)
        addSubview(contentView)
        // 添加进去
        AlertPopupView.containerArray.append(self)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.bounds = bounds
    }

    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let clickPoint = convert(point, to: contentView)
        let isPointInContent = contentView.bounds.contains(clickPoint)
        if isPointInContent {
            if isInteractive {
                return super.hitTest(point, with: event)
            }
            return nil
        } else {
            if isPenetrable == false {
                return super.hitTest(point, with: event)
            }
            return nil
        }

    }
}


extension AlertPopupView {
    
    public func show(animationType: AnimationType, completion: (() -> ())?) {
        if isAnimating {
            return
        }
        isAnimating = true
        containerView.addSubview(self)
        animationStyle = animationType
        contentView.alpha = 0
        backgroundView.alpha = 0
        
        contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        UIView.animate(withDuration: 0.25, delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        
                        self.contentView.alpha = 1
                        self.backgroundView.alpha = 1
                        self.contentView.transform = .identity

        }) { (_) in
            self.isAnimating = false
            completion?()
        }
    }
    
    public func dismiss() {
        if isAnimating {
            return
        }
        isAnimating = true

        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseInOut, animations: {
                        self.contentView.alpha = 0
                        self.backgroundView.alpha = 0
                        self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (_) in

            IQKeyboardManager.shared().resignFirstResponder()
            self.contentView.removeFromSuperview()
            self.removeFromSuperview()
            self.isAnimating = false
            AlertPopupView.containerArray.removeAll {(v) -> Bool in
               return self == v
            }
        }
    }
    
    @objc func backgroundViewClicked() {

        dismiss()
    }
    
    
    /// 隐藏显示
    static func dismiss() {
        
        // 隐藏视图
        AlertPopupView.containerArray.forEach { (pv) in
            if pv.isAnimating {
                pv.containerView.removeFromSuperview()
                pv.isAnimating = false
                pv.removeFromSuperview()
            }else {
                pv.dismiss()
            }
            
        }
        AlertPopupView.containerArray.removeAll()
    }
}

// MARK:  - 类方法弹框
extension AlertPopupView {


    /// 弹出自定义的弹框
    /// - Parameters:
    ///   - contentView: 弹框容器
    ///   - animationType: 动画效果
    ///   - isDismissable: 是否点击黑色背景区域消失
    ///   - completion: 最后的事件回调
    static func showAlertView(contentView: UIView,
                              container: UIView? = UIWindow.key,
                              animationType: AnimationType = .zoomInOut,
                              isDismissable: Bool = true,
                              completion: AlertPopupCompletion?) {
        
        guard let container = container else { return }

        let pop = AlertPopupView(containerView: container, contentView: contentView)
        pop.isDismissable = isDismissable
        pop.show(animationType: animationType, completion: completion)
    }
    
    
    /// loading状态
    /// - Parameters:
    ///   - message: 显示的文本
    ///   - icon: 图标
    static func showLoading( message: String? = nil , icon: UIImage? = nil){
        let loading = AlertLoadingView()

        if let str = message {
            loading.lab_title.text = str
        }
        
        if let image = icon {
            loading.iv_icon.image = image
        }
        
        AlertPopupView.showAlertView(contentView: loading,
                                     container: UIWindow.key,
                                     isDismissable: false) { }
    }
}
