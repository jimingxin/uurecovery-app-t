//
//  AboutViewController.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/24.
//

import UIKit
import PinLayout

class AboutViewController: BaseViewController {

    // 用于滚动
    fileprivate let contentView = UIScrollView().then { sv in
        sv.showsVerticalScrollIndicator = false
    }

    // 主容器
    lazy var v_root = UIView()
    
//    lazy var v_top = AboutTopView()
    lazy var v_team = HomeTeamView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cx.navigationBar?.title = "关于我们"
    }
    
    override func baseAddSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(v_root)
        
        v_root.flex.direction(.column).define { flex in
            flex.addItem(v_team)
        }
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.pin.all(view.safeAreaInsets)
        
        v_root.pin.top(Const.realNavBarHeight).left().right()
        // 使用 flex 进行适配
        v_root.flex.layout(mode: .adjustHeight)
            
        // UIScrollView 进行大小适配
        contentView.contentSize = CGSize(width: v_root.frame.size.width, height: v_root.frame.size.height + Const.safeAreaHeight * 2);
    }

}
