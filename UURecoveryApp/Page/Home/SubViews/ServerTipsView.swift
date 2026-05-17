//
//  ServerTipsView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/9.
//  温馨提示

import UIKit

class ServerTipsView: BaseView {

    lazy var v_root = UIView();
    
    let arr_data: [Resp.QuestionModel] = GlobalModel.arr_tip;
    
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
                    .define { flex in
//                        addFrontLine(flex: flex)
                        let lab = UILabel(title: "温馨提示", textColor: .color_333, blodSize: 16)
                        flex.addItem(lab)
                    }
                
                // 添加提示子项
                (0..<arr_data.count).forEach { index in
                    let item = arr_data[index]
                    addTipItem(flex: flex,  item: item)
                }
                
            }
        
        addSubview(v_root)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.all()
        v_root.flex.layout(mode: .adjustHeight)
    }
    
    
    
    
    /// 添加提示子项
    /// - Parameters:
    ///   - flex: 布局
    ///   - item: 评价的模型
    fileprivate func addTipItem(flex: Flex,item: Resp.QuestionModel) {
        flex.addItem()
            .direction(.column)
            .padding(10)
            .marginHorizontal(10)
            .marginBottom(10)
            .backgroundColor(.hex("#F8F8F8"))
            .cornerRadius(6)
            .define { flex in
            
                // 提示标题
                flex.addItem(UILabel(title: item.problemDesc, textColor: .color_333, blodSize: 12))
                    .marginTop(5)
                
                let lab = UILabel(title: item.answerDesc, textColor: .color_333, fontSize: 12)
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
