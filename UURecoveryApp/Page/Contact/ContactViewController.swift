//
//  ContactViewController.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/6/16.
//

import UIKit
import PinLayout

class ContactViewController: BaseViewController {
    
    // 用于滚动
    fileprivate let contentView = UIScrollView().then { sv in
        sv.showsVerticalScrollIndicator = false
        sv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    
    }
    
    lazy var isHiddenTab = true
    
    // 主容器
    lazy var v_root = UIView()
    
    // 常见问题
    lazy var v_question = ServerQuestionView().then {[weak self] sv in
        sv.callBack = { _ in
            self?.view.setNeedsLayout()
        }
    }
    
    lazy var v_bottom = UIView().then { v in
        v.backgroundColor = .white
    }
    
    lazy var btn_action = UIButton(type: .custom).then { btn in
        btn.setImage(UIImage(named: "kefu_icon"), for: .normal)
        btn.setImage(UIImage(named: "kefu_icon"), for: .highlighted)
        btn.setTitleColor(.color_333, for: .normal)
        btn.setTitle("联系人工客服", for: .normal)
        btn.backgroundColor = .hex("#F8F9FD")
        btn.titleLabel?.font = Const.pingfang_MediumFont375(font: 14)
    }
    
    init(isHiddenTab : Bool = true) {
        super.init()
        self.isHiddenTab = isHiddenTab
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cx.navigationBar?.title = "联系客服"
    }
    
    override func baseAddSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(v_root)
        view.addSubview(v_bottom)
        v_bottom.addSubview(btn_action)
        
        
        v_root.flex.width(Const.screenWidth)
            .direction(.column)
            .define { flex in
            // 常见问题
            flex.addItem(v_question).marginLeft(10).marginRight(10).marginTop(10)
    
        }
        
        btn_action.rx.tap
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance )
            .subscribe {[weak self] _ in
            self?.goToWeb(url: API.DataRecovery.keFu.rawValue,  title: "客服")
        }.disposed(by: disposeBag)
       
    }
    
    
    override func baseAddConstraints() {
        v_bottom.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo( isHiddenTab ? (Const.bottomSafeHeight + 70) : 70)
            make.bottom.equalTo(isHiddenTab ? 0 : -( Const.bottomSafeHeight + 50) )
        }
        
        btn_action.snp.makeConstraints { make in
            make.leading.equalTo(Const.padding)
            make.trailing.equalTo(-Const.padding)
            make.top.equalTo(10)
            make.height.equalTo(48)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.pin.all(view.pin.safeArea)
        
        v_root.pin.top(Const.realNavBarHeight).left().right()
        // 使用 flex 进行适配
        v_root.flex.layout(mode: .adjustHeight)
        btn_action.cx.imagePosition(style: .right, spacing: 5)
        btn_action.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 24).showVisual
        // UIScrollView 进行大小适配
        contentView.contentSize = CGSize(width: v_root.frame.size.width, height: v_root.frame.size.height + Const.safeAreaHeight * 2);
        contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Const.statusBarHeight <= 20 ? 120 : 80, right: 0)
        
    }

    /// 跳转到网页
    /// - Parameter url: url地址
    private func goToWeb(url: String, title:String = "Title") {
//        let vc =  WebViewController()
//        vc.str_url = url
//        vc.backEnable = true
//        vc.str_title = title
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc = KeFuListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
