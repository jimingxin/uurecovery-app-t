//
//  ServerCommentView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/9.
//  服务详情评价

import UIKit

class ServerCommentView: BaseView {
    
    lazy var v_root = UIView();
    
    lazy var lab_title = UILabel.init(title: "UU好评", textColor: .color_main, fontSize: 16).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 18)
    }
    
    
    let arr_data: [GlobalModel.ServerCommentModel] = GlobalModel.arr_commont;
    
    override func baseAddSubViews() {
        v_root.backgroundColor = .white
        v_root.flex.cornerRadius(16).direction(.column)
            .paddingHorizontal(10).define { flex in
                // 标题
                flex.addItem()
                    .direction(.row)
                    .marginHorizontal(0)
                    .alignItems(.center)
                    .marginTop(20)
                    .marginBottom(10)
                    .cornerRadius(16)
                    .define { flex in
//                        addFrontLine(flex: flex)
                        let lab = UILabel(title: "UU好评", textColor: .color_333, blodSize: 16)
                        flex.addItem(lab)
                    }
                
                // 添加问题子项
                (0..<arr_data.count).forEach { index in
                    let item = arr_data[index]
                    addCommentItem(flex: flex,  item: item)
                }
                
            }
        
        addSubview(v_root)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.all()
        v_root.flex.layout(mode: .adjustHeight)
    }
    
    
    
    
    /// 添加评价子项
    /// - Parameters:
    ///   - flex: 布局
    ///   - item: 评价的模型
    fileprivate func addCommentItem(flex: Flex,item: GlobalModel.ServerCommentModel) {
        flex.addItem()
            .direction(.column)
            .padding(10)
            .marginHorizontal(10)
            .marginBottom(10)
            .backgroundColor(.hex("#F8F8F8"))
            .cornerRadius(6)
            .define { flex in
            
                // 姓名
                flex.addItem(UILabel(title: item.name, textColor: .color_333, blodSize: 12))
                    .marginTop(5)
                
                // 评价的星
                flex.addItem().direction(.row).define { flex in
                    // 评价的星星
                    (0..<5).forEach { index in
                        if (index < item.star) {
                            flex.addItem(UIImageView(imageName: "ser_star"))
                                .height(9)
                                .width(9)
                                .marginRight(2)
                        } else {
                            flex.addItem(UIImageView(imageName: "ser_star_gray"))
                                .height(9)
                                .width(9)
                                .marginRight(2)
                        }
                    }
                    
                }
                
                // 具体的评价
                let lab = UILabel(title: item.desc, textColor: .color_333, fontSize: 12)
                lab.numberOfLines = 0
                flex.addItem(lab).marginTop(10)
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
