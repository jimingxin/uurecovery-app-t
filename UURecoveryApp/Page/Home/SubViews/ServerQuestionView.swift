//
//  ServerQuestionView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/9.
//

import UIKit

class ServerQuestionView: BaseView {
    
    
    var callBack:CompleteAction?
    
    lazy var v_root = UIView();
    
    lazy var lab_title = UILabel.init(title: "关于我们", textColor: .color_main, fontSize: 16).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 18)
    }
    
    // 常见问题
    fileprivate var arr_question:[Resp.QuestionModel] = []
    
    var arr_flex: [Flex] = []
    
    var arr_lab: [UILabel] = []
    
    let arr_tags = ["kefu_tag","kefu_tag2","kefu_tag3","kefu_tag4","kefu_tag5","kefu_tag6","kefu_tag7","kefu_tag8","kefu_tag9","kefu_tag10"]
    
    override func baseAddSubViews() {
        
        (0..<GlobalModel.arr_question.count).forEach { index in
            var item = GlobalModel.arr_question[index]
            item.isClose = true
            arr_question.append(item)
        }
        
        v_root.backgroundColor = .white
        v_root.flex.direction(.column)
            .paddingHorizontal(10)
            .paddingBottom(10)
            .cornerRadius(16)
            .define { flex in
                // 标题
                flex.addItem()
                    .direction(.row)
                    .marginHorizontal(0)
                    .alignItems(.center)
                    .marginTop(20)
                    .marginBottom(10)
                    .define { flex in
//                        addFrontLine(flex: flex)
                        let lab = UILabel(title: "常见问题", textColor: .color_333, fontSize: 16)
                        lab.font = Const.pingfang_MediumFont375(font: 16)
                        flex.addItem(lab)
                    }
                
                // 添加问题子项
                (0..<arr_question.count).forEach { index in
                    let item = arr_question[index]
                    addQuestionItem(flex: flex, item: item, index: index)
                }
                
            }
        
        addSubview(v_root)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.all()
        v_root.flex.width(100%).layout(mode: .adjustHeight)
    }
    
    
    /// 添加常见问题子项
    /// - Parameters:
    ///   - flex: 布局
    ///   - title: 标题
    ///   - desc: 描述
    fileprivate func addQuestionItem(flex: Flex, item: Resp.QuestionModel, index: Int = 0) {
                
        let flex_t = flex.addItem()
            .direction(.column)
            .marginHorizontal(10)
            .define { flex in
                // 标题
                flex.addItem()
                    .width(100%)
                    .direction(.row)
                    .marginTop(10)
                    .alignItems(.center)
                    .define { flex in
                        
                        let lab = UILabel(title: item.problemDesc, textColor: .color_333, fontSize: 14).then { lab in
                            lab.font = Const.pingfang_MediumFont375(font: 14)
                            lab.adjustsFontSizeToFitWidth = true
                        }
                        if index < arr_tags.count {
                            flex.addItem(UIImageView(imageName: arr_tags[index])).width(14).height(14)
                        }
                        flex.addItem(lab).marginLeft(6).marginRight(30)
                        flex.addItem(UIImageView(imageName: "mine_arrow_down"))
                            .width(12).height(12)
                            .position(.absolute)
                            .right(0)
                    }
                
                // 添加描述
                flex.addItem()
                    .padding(10)
                    .marginTop(10)
                    .backgroundColor(item.isClose! ? .white : .hex("#F8F8F8"))
                    .cornerRadius(6)
                    .define { flex in
                        let lab = UILabel(title: item.isClose! ? "" : item.answerDesc, textColor: .color_333, fontSize: 12)
                        lab.numberOfLines = 0
                        flex.addItem(lab)
                        lab.tag = 100 + index
                        arr_lab.append(lab)
                    }
                
            }
        flex_t.view?.tag = 200 + index
        flex_t.view?.cx.addTapGesture(target: self, action: #selector(tapAction(tap:)))
        arr_flex.append(flex_t)
    }
    
    fileprivate func addFrontLine(flex:Flex){
        flex.addItem()
            .width(2)
            .height(12)
            .cornerRadius(1)
            .marginRight(5)
            .backgroundColor(.color_main)
    }
    
    @objc func tapAction(tap: UITapGestureRecognizer) {
        let view = tap.view;
        let index_t : Int = (view?.tag ?? 200) - 200;

        if index_t != -1 {
            let lab = arr_lab[index_t]
            let flex = arr_flex[index_t]
            var item = arr_question[index_t]
            item.isClose = !(item.isClose!)
            lab.text = item.isClose! == true ? "" : item.answerDesc
            arr_question[index_t] = item
            lab.flex.markDirty()
            flex.markDirty()
            v_root.flex.markDirty()
            if let callBack = self.callBack {
                callBack(true)
            }
        }
        
    }
}
