//
//  AlertView.swift
//  CXMerchant
//
//  Created by zain guo on 2020/10/15.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit
import WebKit

extension AlertView {
    
    class func show(containerView: UIView? = UIWindow.key,
                    title: String? = "",
                    message: String,
                    attributMsg: NSAttributedString = NSAttributedString(string: ""),
                    leftItemTitle: String,
                    rightItemTitle: String?,
                    seconds: Int? = 0,
                    hasBottomCloseItem: Bool? = false,
                    isDismissable: Bool = false,
                    configure: AlertViewConfig = AlertViewConfig(),
                    leftItemBlock: ((AlertView) -> ())?,
                    rightItemBlock: ((AlertView) -> ())?) {
        
        guard let container = containerView  else { return }
        
        var config = configure
        config.hasBottomCloseItem = hasBottomCloseItem!
        
        let alert = AlertView(title: title,
                              message: message,
                              attributMsg: attributMsg,
                              leftItemTitle: leftItemTitle,
                              rightItemTitle: rightItemTitle,
                              seconds: seconds,
                              configure: config)
        
        
        let pop = AlertPopupView(containerView: container, contentView: alert)
        pop.isDismissable = isDismissable
        
        alert.dismiss = {
            pop.dismiss()
        }
        alert.leftItemBlock = { (alertView) in
            pop.dismiss()
            leftItemBlock?(alertView)
        }
        alert.rightItemBlock = { (alertView) in
            pop.dismiss()
            rightItemBlock?(alertView)
        }
        pop.show(animationType: .zoomInOut, completion: nil)
    }
    
    
    
    static func showAlert(title: String? = "",
                          message: String,
                          leftItemTitle: String,
                          rightItemTitle: String?,
                          rightItemColor: UIColor = .color_main,
                          isDismissable: Bool = false,
                          leftItemBlock: ((AlertView) ->())?,
                          rightItemBlock: ((AlertView) -> ())?) {
        
        // 弹框
        let config = AlertView.AlertViewConfig(space: 48, titleColor: .color_333, titleFont: UIFont.cx.pingfangMedium(ofSize: 18), messageColor: .color_333, messageFont: UIFont.cx.pingfangRegular(ofSize: 15), leftItemColor:  .color_333, leftItemFont: UIFont.cx.pingfangRegular(ofSize: 18), rightItemColor: rightItemColor, rightItemFont:  UIFont.cx.pingfangRegular(ofSize: 18), hasBottomCloseItem: false, onlyOneItem: false, isDismissable: isDismissable)
        
        AlertView.show( title: title, message: message, leftItemTitle: leftItemTitle, rightItemTitle: rightItemTitle, hasBottomCloseItem: false, isDismissable: isDismissable, configure: config, leftItemBlock: leftItemBlock, rightItemBlock: rightItemBlock)
        
    }
    
    static func showTitleAlert(title: String? = "",
                               isDismissable: Bool = false,
                               rightItemTitle: String?,
                               rightItemBlock: ((AlertView) -> ())?) {
        
        // 弹框
        let config = AlertView.AlertViewConfig(space: 48, titleColor: .color_333, titleFont: UIFont.cx.pingfangMedium(ofSize: 18), messageColor: .color_333, messageFont: UIFont.cx.pingfangMedium(ofSize: 18), leftItemColor:  .color_333, leftItemFont: UIFont.cx.pingfangRegular(ofSize: 18), rightItemColor: .color_main, rightItemFont:  UIFont.cx.pingfangRegular(ofSize: 18), hasBottomCloseItem: false, onlyOneItem: false, isDismissable: isDismissable)
        
        AlertView.show( title: "", message: title ?? "", leftItemTitle: "", rightItemTitle: rightItemTitle, hasBottomCloseItem: false, isDismissable: isDismissable, configure: config, leftItemBlock: nil, rightItemBlock: rightItemBlock)
        
    }
}

@objcMembers
public class AlertView: UIView {
    
    struct AlertViewConfig {
        
        var space: CGFloat = 48
        var titleColor: UIColor? = .color_333
        var titleFont: UIFont? = UIFont.cx.pingfangMedium(ofSize: 18)
        
        var messageColor = UIColor.hex("333333")
        var messageFont = Const.pingfang_RegularFont375(font: 15)
        var leftItemColor = UIColor.hex("333333")
        var leftItemFont = Const.pingfang_RegularFont375(font: 18)
        var rightItemColor = UIColor.color_main
        var rightItemFont = Const.pingfang_RegularFont375(font: 18)
        var hasBottomCloseItem = false
        var onlyOneItem = false
        var isDismissable = false
        
    }
    
    public var dismiss: (()->())?
    public var leftItemBlock: ((AlertView) -> ())?
    public var rightItemBlock: ((AlertView) -> ())?
    
    private static let contentTag = 1000
    
    private let title: String?
    private let message: String
    private let attributMsg: NSAttributedString
    /// 按钮倒计时秒
    private let seconds: Int?
    private let leftItemTitle: String?
    private let rightItemTitle: String?
    private var config: AlertViewConfig
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.tag = AlertView.contentTag
        addSubview(view)
        return view
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.text = title
        lab.font = config.titleFont
        lab.textColor = config.titleColor
        contentView.addSubview(lab)
        return lab
    }()
    
    private lazy var messageLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textAlignment = .center
        lab.text = message
        lab.textColor = config.messageColor
        lab.font = config.messageFont
        contentView.addSubview(lab)
        return lab
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hex("e5e5e5")
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var leftItem: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(leftItemTitle, for: .normal)
        btn.setTitleColor(config.leftItemColor, for: .normal)
        btn.titleLabel?.font = config.leftItemFont
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(leftItemClick(item:)), for: .touchUpInside)
        contentView.addSubview(btn)
        return btn
    }()
    
    private lazy var rightItem: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(rightItemTitle, for: .normal)
        btn.setTitleColor(config.rightItemColor, for: .normal)
        btn.titleLabel?.font = config.rightItemFont
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(rightItemClick(item:)), for: .touchUpInside)
        contentView.addSubview(btn)
        return btn
    }()
    private lazy var v_line: UIView = {
        let view = UIView()
        view.backgroundColor = line.backgroundColor
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "log_in_button_fork"), for: .normal)
        btn.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        addSubview(btn)
        return btn
    }()
    
    private init(title: String?,
                 message: String,
                 attributMsg: NSAttributedString,
                 leftItemTitle: String,
                 rightItemTitle: String?,
                 seconds: Int?,
                 configure: AlertViewConfig = AlertViewConfig()) {
        
        self.title = title
        self.message = message
        self.leftItemTitle = leftItemTitle
        self.rightItemTitle = rightItemTitle
        self.config = configure
        self.seconds = seconds
        self.attributMsg = attributMsg
        
        super.init(frame: .zero)
        
        setupUI()
        setupTimeCount()
    }
    
    private func setupTimeCount() {
        
        guard let seconds = seconds, seconds > 0 else {
            return
        }
        let title = self.leftItemTitle ?? ""
        
        leftItem.isUserInteractionEnabled = false
        leftItem.setTitle("\(title)（\(seconds)）", for: .normal)
        
        dispatchTimer(timeInterval: 1,
                      repeatCount: seconds) {  [weak self](_, time) in
            
            guard let `self` = self else { return }
            self.leftItem.setTitle(time == 0 ? title : "\(title)（\(time)）",
                                   for: .normal)
            
            self.leftItem.isUserInteractionEnabled = time == 0
            
        }
    }
    
    /// GCD定时器倒计时
    ///
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - repeatCount: 重复次数
    ///   - handler: 循环事件,闭包参数: 1.timer 2.剩余执行次数
    func dispatchTimer(timeInterval: Double,
                       repeatCount: Int,
                       handler: @escaping (DispatchSourceTimer?, Int) -> Void) {
        
        if repeatCount <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            count -= 1
            DispatchQueue.main.async {
                handler(timer, count)
            }
            if count == 0 {
                timer.cancel()
            }
        }
        timer.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension AlertView {
    
    func getTitle() -> String? {
        return self.title
    }
    
    private func setupUI() {
        
        contentView.cx.x = config.space
        contentView.cx.width = Const.screenWidth - config.space * 2
        
        if let count = title?.count, count > 0   {
            
            titleLab.text = title
            titleLab.frame = CGRect(x: 12, y: 20, width: contentView.cx.width - 24, height: 30)
        }
        let messageHeight = message.cx.getHeight(font: config.messageFont,
                                                 fixedWidth: contentView.cx.width - 25)
        
        messageLab.frame = CGRect(x: 12,
                                  y: titleLab.cx.bottom + 25,
                                  width: contentView.cx.width - 24,
                                  height: messageHeight)
        
        // 如果富文本不为空，设置富文本属性
        if attributMsg.length > 0 {
            let attributHeight = attributMsg.string.cx.getHeight(font: config.messageFont, fixedWidth: contentView.cx.width - 25)
            
            messageLab.frame = CGRect(x: 12,
                                      y: titleLab.cx.bottom + 25,
                                      width: contentView.cx.width - 24,
                                      height: attributHeight)
            messageLab.attributedText = attributMsg
        }
        
        line.frame = CGRect(x: 0,
                            y: messageLab.cx.bottom + 25,
                            width: contentView.cx.width,
                            height: 0.5)
        
        if rightItemTitle?.cx.isEmpty() == true || leftItemTitle?.cx.isEmpty() == true {
            config.onlyOneItem = true
        }
        if config.onlyOneItem {
            
            if leftItemTitle?.cx.isEmpty() == true {
                rightItem.frame = CGRect(x: 0,
                                         y: line.cx.bottom,
                                         width: contentView.cx.width,
                                         height: 48)
            }else {
                leftItem.frame = CGRect(x: 0,
                                        y: line.cx.bottom,
                                        width: contentView.cx.width,
                                        height: 48)
            }
            
        } else {
            
            leftItem.frame = CGRect(x: 0,
                                    y: line.cx.bottom,
                                    width: contentView.cx.width/2.0,
                                    height: 48)
            v_line.frame = CGRect(x: leftItem.cx.right,
                                  y: line.cx.bottom,
                                  width: 0.5,
                                  height: leftItem.cx.height)
            
            rightItem.frame = CGRect(x: leftItem.cx.right,
                                     y: line.cx.bottom,
                                     width: leftItem.cx.width - 0.5,
                                     height: leftItem.cx.height)
        }
        if leftItemTitle?.cx.isEmpty() == false {
            contentView.cx.height = leftItem.cx.bottom
        } else if rightItemTitle?.cx.isEmpty() == false {
            contentView.cx.height = rightItem.cx.bottom
        }else {
            v_line.cx.height = 0
            contentView.cx.height = messageLab.cx.bottom
        }
        
        
        self.frame = CGRect(x: 0,
                            y: (Const.screenHeight - contentView.cx.bottom)/2.0,
                            width: Const.screenWidth,
                            height: contentView.cx.bottom)
        
        if config.hasBottomCloseItem == true {
            closeBtn.isHidden = false
            closeBtn.cx.centerX = cx.centerX
            closeBtn.cx.y = contentView.cx.bottom + 10
            
            self.frame = CGRect(x: 0,
                                y: (Const.screenHeight - closeBtn.cx.bottom)/2.0,
                                width: contentView.cx.width,
                                height: closeBtn.cx.bottom)
        }
    }
    
}

// MARK: - Target Action
extension AlertView {
    @objc func closeBtnClick() {
        dismiss?()
    }
    @objc func leftItemClick(item: UIButton) {
        
        let superView = item.superview
        let alert = superView?.superview as! AlertView
        leftItemBlock?(alert)
    }
    @objc func rightItemClick(item: UIButton) {
        
        let superView = item.superview
        let alert = superView?.superview as! AlertView
        rightItemBlock?(alert)
    }
}


// MARK: - 自定义红包成功的弹框
public class AlertStateView: BaseView {
    
    // 背景
    lazy var v_bg = UIView().then { (v) in
        v.backgroundColor = .white
    }
    
    // 图标
    lazy var iv_icon = UIImageView().then { (iv) in
        iv.image = UIImage(named: "give_redpacket_pop_bg_succeed")
    }
    
    // 标题
    lazy var lab_title = UILabel(title: "红包发送成功", textColor: UIColor.color_333, fontSize: 18).then { (lab) in
        lab.font = UIFont.cx.pingfangMedium(ofSize: 18)
        lab.textAlignment = .center
    }
    
    // 查看详情
    lazy var btn_show = UIButton(title: "查看详情", fontSize: 14, normalColor: .color_main)
    
    // 关闭
    lazy var btn_close = UIButton(image: UIImage(named: "give_redpacket_pop_button_delete")).then { (btn) in
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // 按钮点击
    var btn_show_tap: AlertPopupCompletion
    // 按钮点击
    var btn_close_tap: AlertPopupCompletion
    
    
    /// 初始化器
    /// - Parameters:
    ///   - show: 显示回调
    ///   - close: 关闭回调
    init(show: @escaping AlertPopupCompletion, close: @escaping AlertPopupCompletion) {
        self.btn_show_tap = show
        self.btn_close_tap = close
        super.init(frame: CGRect.zero)
        
    }
    
    convenience init(close: @escaping AlertPopupCompletion){
        self.init (show: {} , close: close)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func baseConfig() {
        super.baseConfig()
        backgroundColor = .clear
        
        btn_show.rx.tap.subscribe(onNext: { [weak self] in
            defer {
                if let sv = self?.superview  as? AlertPopupView {
                    sv.dismiss()
                }
            }
            if let block = self?.btn_show_tap {
                block()
            }
            
        }).disposed(by: disposeBag)
        
        btn_close.rx.tap.subscribe(onNext: { [weak self] in
            defer {
                if let sv = self?.superview  as? AlertPopupView {
                    sv.dismiss()
                }
            }
            if let block = self?.btn_close_tap {
                block()
            }
        }).disposed(by: disposeBag)
    }
    
    override func baseAddSubViews() {
        super.baseAddSubViews()
        addSubview(v_bg)
        addSubview(btn_close)
        [ iv_icon, lab_title, btn_show].forEach { (v) in
            self.v_bg.addSubview(v)
        }
    }
    
    override func baseAddConstraints() {
        super.baseAddConstraints()
        
        v_bg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(btn_show.snp.bottom).offset(15)
        }
        
        iv_icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(v_bg.snp.centerX)
            make.top.equalToSuperview().offset(30)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        lab_title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iv_icon.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        btn_show.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lab_title.snp.bottom).offset(16)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        btn_close.snp.makeConstraints { (make) in
            make.top.equalTo(v_bg.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.centerX.equalToSuperview()
        }
        
        Asyncs.delay(0.1) {
            self.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.centerY.equalToSuperview()
                make.bottom.equalTo(self.btn_close.snp.bottom).offset(30)
            }
            self.layoutIfNeeded()
            self.v_bg.clearVisual
                .conrnerCorner(corner: .allCorners)
                .conrnerRadius(radius: 8)
                .showVisual
        }
        
    }
    
}

class AlertLoadingView: BaseView {
    // 图标
    lazy var iv_icon = UIImageView().then { (iv) in
        iv.image = UIImage(named: "wait")
    }
    
    // 标题
    lazy var lab_title = UILabel(title: "处理中...", textColor: UIColor.color_333, fontSize: 18).then { (lab) in
        lab.font = UIFont.cx.pingfangMedium(ofSize: 18)
        lab.textAlignment = .center
    }
    
    override func baseAddSubViews() {
        backgroundColor = .white
        addSubview(iv_icon)
        addSubview(lab_title)
    }
    
    override func baseAddConstraints() {
        
        self.frame = CGRect(x: 45, y: 0, width: Const.screenWidth - 100, height: 0)
        iv_icon.frame = CGRect(x: 0, y: 30, width: 40, height: 40)
        
        lab_title.frame = CGRect(x: 10, y: iv_icon.cx.bottom + 20, width: self.cx.width - 20, height: 25)
        
        var frame = self.frame
        frame.size.height = lab_title.cx.bottom + 30
        self.frame = frame
        self.center = CGPoint(x: Const.screenWidth / 2, y: Const.screenHeight / 2)
        iv_icon.cx.centerX = (self.cx.width) / 2
        
        self.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 8).showVisual
    }
}


// MARK: - 自定义输入用户名和手机号
public class AlertInputView: BaseView {
    
    // 背景
    lazy var v_bg = UIView().then { (v) in
        v.backgroundColor = .white
    }
    // 标题
    lazy var lab_title = UILabel(title: "请留下联系方式", textColor: UIColor.color_333, fontSize: 18).then { (lab) in
        lab.font = UIFont.cx.pingfangMedium(ofSize: 18)
        lab.textAlignment = .center
    }
    
    lazy var lab_phone = UILabel(title: "手机号:", textColor: .color_333, fontSize: 18)
    lazy var lab_name = UILabel(title: "姓名:", textColor: .color_333, fontSize: 18)
    
    lazy var tf_phone = UITextField().then { tf in
        tf.placeholder = "请输入手机号"
        tf.textColor = .color_333
        tf.keyboardType = .numberPad
        tf.font = Const.pingfang_RegularFont375(font: 15)
        tf.borderStyle = .roundedRect
    }
    
    lazy var tf_name = UITextField().then { tf in
        tf.placeholder = "请输入用户名"
        tf.textColor = .color_333
        tf.font = Const.pingfang_RegularFont375(font: 15)
        tf.borderStyle = .roundedRect
    }
    
    // 确定
    lazy var btn_show = UIButton(title: "确定", fontSize: 16, normalColor: .white).then { btn in
        btn.backgroundColor = .color_main
    }
    
    lazy var btn_close = UIButton(image: UIImage(named: "close")).then { btn in
        btn.setTitleColor(.color_666, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    // 按钮点击
    var btn_show_tap: AlertInputCompletion
    // 按钮点击
    var btn_close_tap: AlertPopupCompletion
    
    
    /// 初始化器
    /// - Parameters:
    ///   - show: 显示回调
    ///   - close: 关闭回调
    init(show: @escaping AlertInputCompletion, close: @escaping AlertPopupCompletion) {
        self.btn_show_tap = show
        self.btn_close_tap = close
        super.init(frame: CGRect.zero)
        
    }
    
    convenience init(show: @escaping AlertInputCompletion){
        self.init (show: show , close: {})
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func baseConfig() {
        super.baseConfig()
        backgroundColor = .clear
        
        btn_show.rx.tap.subscribe(onNext: { [weak self] in
            
            guard let sv = self?.superview  as? AlertPopupView,
                let phone = self?.tf_phone.text, phone.count > 0
            else {
                MBProgressHUD.yx_showMessage("手机号不能为空")
                return
            }
            
            if phone.count != 11 {
                MBProgressHUD.yx_showMessage("请输入正确的手机号")
                return
            }
            
            if let block = self?.btn_show_tap {
                block(phone, self?.tf_name.text ?? "")
                sv.dismiss()
            }
            
        }).disposed(by: disposeBag)
        
        btn_close.rx.tap.subscribe(onNext: { [weak self] in
            guard let sv = self?.superview  as? AlertPopupView else {
                return
            }
            if let block = self?.btn_close_tap {
                block()
            }
            sv.dismiss()
        }).disposed(by: disposeBag)
        
        Asyncs.delay(0.1) {
            
            self.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.centerY.equalToSuperview().offset(-60)
                make.bottom.equalTo(self.btn_show.snp.bottom).offset(30)
            }
            self.layoutIfNeeded()
            
            self.v_bg.clearVisual
                .conrnerCorner(corner: .allCorners)
                .conrnerRadius(radius: 8)
                .showVisual
            self.btn_show.clearVisual.conrnerCorner(corner: .allCorners)
                .conrnerRadius(radius: 8)
                .showVisual
        }
        
        
    }
    
    override func baseAddSubViews() {
        super.baseAddSubViews()
        addSubview(v_bg)
        [ lab_title, btn_show, lab_phone, lab_name, tf_phone, tf_name, btn_close].forEach { (v) in
            self.v_bg.addSubview(v)
        }
    }
    
    override func baseAddConstraints() {
        super.baseAddConstraints()
        
        v_bg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(btn_show.snp.bottom).offset(15)
        }
    
        
        lab_title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(15)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        btn_close.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(lab_title.snp.centerY)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        lab_phone.snp.makeConstraints { make in
            make.top.equalTo(lab_title.snp.bottom).offset(30)
            make.leading.equalTo(Const.padding)
            make.width.equalTo(60)
        }
        
        lab_name.snp.makeConstraints { make in
            make.top.equalTo(tf_phone.snp.bottom).offset(20)
            make.leading.equalTo(Const.padding)
            make.width.equalTo(60)
        }
        
        tf_phone.snp.makeConstraints { make in
            make.centerY.equalTo(lab_phone.snp.centerY)
            make.leading.equalTo(lab_phone.snp.trailing).offset(5)
            make.trailing.equalTo(-Const.padding)
            make.height.equalTo(40)
        }
        
        tf_name.snp.makeConstraints { make in
            make.centerY.equalTo(lab_name.snp.centerY)
            make.leading.equalTo(lab_name.snp.trailing).offset(5)
            make.trailing.equalTo(-Const.padding)
            make.height.equalTo(40)
        }
        
        btn_show.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lab_name.snp.bottom).offset(40)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
}
