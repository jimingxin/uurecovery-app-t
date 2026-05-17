//
//  MineOrderView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/22.
//

import UIKit

class MineOrderView: BaseView {
    
    lazy var v_root = UIView()
    
    var target: UIViewController?
    
    lazy var lab_mine_order = UILabel.init(title: "我的订单", textColor: .color_333, fontSize: 18).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 18)
    }
    
    lazy var lab_mine_all = UILabel.init(title: "查看全部>", textColor: .color_888, fontSize: 14)
    
    fileprivate let arr_img = ["mine_order_to","mine_order_done","mine_order_server","mine_order_all"]
    fileprivate let arr_title = ["待付款", "已付款", "售后客服", "我的订单"]
    
    override func baseAddSubViews() {
        addSubview(v_root)
        v_root.flex
            .direction(.column)
            .marginHorizontal(10)
            .define { flex in
                //            flex.addItem().direction(.row).justifyContent(.spaceBetween).define { flex in
                //                flex.addItem(lab_mine_order)
                //                flex.addItem(lab_mine_all).marginRight(8)
                //            }
                // 具体订单
                flex.addItem().direction(.row)
                    .justifyContent(.spaceBetween)
                    .marginTop(10)
                    .paddingHorizontal(15)
                    .paddingVertical(20)
                    .backgroundColor(.white)
                    .cornerRadius(14)
                    .define { flex in
                        (0..<arr_title.count).forEach { index in
                            let  item_flex =  flex.addItem().direction(.column)
                                .justifyContent(.center)
                                .alignItems(.center)
                                .aspectRatio(1)
                                .define { flex in
                                    flex.addItem(UIImageView(imageName: arr_img.get(at: index)!)).size(28)
                                    flex.addItem(UILabel(title: arr_title.get(at: index)!, textColor: .color_333, fontSize: 12))
                                        .marginTop(3)
                                }
                            item_flex.view?.tag = 100 + index
                            item_flex.view?.cx.addTapGesture(target: self, action: #selector(itemClick(sender: )))
        
                        }
                        flex.addItem(UIImageView(imageName: "mine_divider"))
                            .width(5)
                            .height(55)
                            .position(.absolute)
                            .alignSelf(.center)
                            .right((Const.screenWidth - 60) / 4)
                    }
            }
        
    }
    
    override func baseAddConstraints() {
        self.snp.makeConstraints { make in
            make.bottom.equalTo(v_root.snp.bottom).offset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.top().left().right()
        v_root.flex.layout(mode: .adjustHeight)
        
    }
    
    @objc func itemClick(sender: UITapGestureRecognizer) {
       
        guard  let tag = sender.view?.tag else { return }
        
        if tag == 100 {
        
            let vc = ServiceItemController(pageType: ServiceItemController.PageType.CREATED)
            vc.isInTab = false
            vc.cx.navigationBar?.title = "订单-待付款"
            vc.cx.navigationBar?.leftImage = "common_icon_bg_color"
            self.target?.navigationController?.pushViewController(vc, animated: true)
            return
        
        } else if(tag == 101){
            let vc = ServiceItemController(pageType: ServiceItemController.PageType.PAID)
            vc.isInTab = false
            vc.cx.navigationBar?.leftImage = "common_icon_bg_color"
            vc.cx.navigationBar?.title = "订单-已付款"
            
            self.target?.navigationController?.pushViewController(vc, animated: true)
        }else if(tag == 102){
            // 跳转到客服
//            self.goToWeb(url: API.DataRecovery.keFu.rawValue, title: "客服")
            let vc = ContactViewController()
            target?.navigationController?.pushViewController(vc, animated: true)
        }else if(tag == 103){
            // 跳转到订单页面
            if let app = UIApplication.shared.delegate as? AppDelegate,
                let tab = app.rootController as? CustomTabBarController {
                tab.curIndex = 1
                tab.selectedIndex = 1
            }
            
        }
        
    }
    
    /// 跳转到网页
    /// - Parameter url: url地址
    private func goToWeb(url: String, title:String = "Title") {
        let vc =  WebViewController()
        vc.str_url = url
        vc.backEnable = true
        vc.str_title = title
        target?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
