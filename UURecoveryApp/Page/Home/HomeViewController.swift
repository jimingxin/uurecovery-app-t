//
//  HomeViewController.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/18.
//

import UIKit

class HomeViewController: BaseViewController {
    
    fileprivate var mainView: HomeBaseView {
        return self.view as! HomeBaseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        cx.navigationBar?.rightItem.rx.tap.subscribe(onNext: {[weak self] _ in
//            self?.goToWeb(url: API.DataRecovery.keFu.rawValue,  title: "客服")
//        }).disposed(by: disposeBag)
        cx.navigationBar?.allBackgroundColor = .clear
        cx.navigationBar?.titleColor = .white
        cx.navigationBar?.leftImage = "back_white"
        
    }
    
    override func loadView() {
        view = HomeBaseView.init(isCon: true, vc: self);
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        if (cx.navigationBar?.rightItem.cx.width ?? 0) > 0 {
//            cx.navigationBar?.rightItem.clearVisual
//                .conrnerCorner(corner: .allCorners)
//                .conrnerRadius(radius: 15)
//                .borderColor(color: .hex("#9AA8C5"))
//                .borderWidth(width: 1)
//                .showVisual
//        }
    }
    
    override func configNavigationBar() {
//        cx.navigationBar?.rightImage = "home_kf"
//        cx.navigationBar?.rightTitle = "客服咨询"
//        cx.navigationBar?.rightItem.frame = CGRectMake(Const.screenWidth - 110, 7, 100, 30)
//        cx.navigationBar?.rightItem.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        cx.navigationBar?.rightItem.setTitleColor(.color_main, for: .normal)
//        cx.navigationBar?.rightItem.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    /// 跳转到网页
    /// - Parameter url: url地址
    private func goToWeb(url: String, title:String = "Title") {
        let vc =  WebViewController()
        vc.str_url = url
        vc.backEnable = true
        vc.str_title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
