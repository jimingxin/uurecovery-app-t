//
//  ServerFlowView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/9.
//

import UIKit

class ServerFlowView: BaseView {

    lazy var v_root = UIView()
    
    fileprivate let arr_img = ["server_flow_one","server_flow_two","server_flow_three","server_flow_four"]
    fileprivate let arr_title = ["提交订单", "arrow" , "安排工程师","arrow", "一对一操作","arrow", "成功恢复"]
    
    override func baseAddSubViews() {
        backgroundColor = .white
        addSubview(v_root)
        v_root.flex
            .direction(.column)
            .marginHorizontal(15)
            .define { flex in
        
                flex.addItem()
                    .direction(.row)
                    .alignItems(.center)
                    .marginHorizontal(0)
                    .marginTop(20)
                    .marginBottom(10)
                    .define { flex in
//                        addFrontLine(flex: flex)
                        let lab = UILabel(title: "服务流程", textColor: .color_333, fontSize: 16)
                        lab.font = Const.pingfang_MediumFont375(font: 16)
                        flex.addItem(lab)
                    }
                
                // 具体订单
                flex.addItem().direction(.row)
                    .justifyContent(.spaceBetween)
                    .alignItems(.center)
                    .paddingHorizontal(5)
                    .paddingBottom(20)
                    .define { flex in
                        (0..<arr_title.count).forEach { index in
                            if let str = arr_title.get(at: index), str == "arrow" {
                                flex.addItem(UIImageView(imageName: "server_flow_arrow"))
                                    .width(21).height(7)
                                    .position(.relative)
                                    .top(-10)
                            } else {
                                flex.addItem().direction(.column)
                                    .justifyContent(.center)
                                    .alignItems(.center)
                                    .aspectRatio(1)
                                    .define { flex in
                                        flex.addItem(UIImageView(imageName: arr_img.get(at: index / 2)!)).size(40)
                                        flex.addItem(UILabel(title: arr_title.get(at: index)!, textColor: .color_333, fontSize: 12))
                                            .marginTop(3)
                                    }
                            
                            }
                            
                        }
                    
                    }
            }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.top().left().right()
        v_root.flex.layout(mode: .adjustHeight)
        
        if self.cx.width > 0 {
            self.clearVisual.conrnerCorner(corner: .allCorners).conrnerRadius(radius: 16).showVisual
        }
        
    }
    
    fileprivate func addFrontLine(flex:Flex){
        flex.addItem()
            .width(2)
            .height(12)
            .cornerRadius(1)
            .marginRight(5)
            .backgroundColor(.color_main)
    }

}
