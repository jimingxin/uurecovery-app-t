//
//  HomeRecoveryChildView.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/20.
//

import UIKit

class HomeRecoveryChildView: BaseView {
    
    weak var target:UIViewController?
    
    lazy var v_root = UIView();
    lazy var lab_title = UILabel(title: "近期热门恢复", textColor: .color_333, fontSize: 16).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 16)
    }
    
    lazy var lab_title_bottom = UILabel(title: "其他恢复服务", textColor: .color_333, fontSize: 18).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 16)
    }
    fileprivate let arr_one = [ GlobalModel.ProductType.WX_RECORD,
                                GlobalModel.ProductType.WX_FRIEND,
                                GlobalModel.ProductType.PHOTO ]
    fileprivate var arr_two = [
        GlobalModel.ProductType.MIC,
        GlobalModel.ProductType.QQ,
        GlobalModel.ProductType.MEMO,
        GlobalModel.ProductType.MESSAGE ,
        GlobalModel.ProductType.WX_ORDER,
        GlobalModel.ProductType.CALL,
        GlobalModel.ProductType.SOFT,
        GlobalModel.ProductType.DEL,
        
        ]
    fileprivate let arr_one_img = ["home_wechat","home_wechat_fr","home_pic"]
    fileprivate let arr_two_img = ["home_micro","home_qq","home_remark","home_msg","home_wx_order","home_link","home_soft","home_del"]
    
    
    let lab_temp_one = UILabel(title: GlobalModel.ProductType.WX_RECORD.desc, textColor: .color_main, blodSize: 14)
    
    let lab_temp_two = UILabel(title: GlobalModel.ProductType.WX_FRIEND.desc, textColor: .color_main, blodSize: 14)
    
    let lab_temp_three  = UILabel(title: GlobalModel.ProductType.PHOTO.desc, textColor: .color_main, blodSize: 14)
    // qq恢复
    var lab_temp_qq: UILabel?
    
    var arr_lab_one : [UILabel] = []
    var arr_lab_two : [UILabel] = []
    
    
    override func baseAddSubViews() {
        
        v_root.flex.direction(.column)
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem()
                    .marginHorizontal(10)
                    .width(Const.screenWidth - 20)
                    .backgroundColor(.white)
                    .cornerRadius(Const.globalCorner * 2)
                    .define { flex in
                        
                        flex.addItem()
                            .direction(.row)
                            .alignItems(.center)
                            .marginHorizontal(12)
                            .marginTop(16)
                            .marginBottom(5)
                            .define { flex in
//                                addFrontLine(flex: flex)
                                flex.addItem(lab_title)
                            }
                        // 热门
                        flex.addItem()
                            .marginHorizontal(10)
                            .marginBottom(5)
                            .direction(.row)
                            .justifyContent(.spaceAround)
                            .define { flex in
                                (0..<arr_one.count).forEach { index in
                                    let  item_flex =  flex.addItem().direction(.column)
                                        .justifyContent(.center)
                                        .alignItems(.center)
                                        .aspectRatio(0.75)
                                        .define { flex in
                                            
                                            let lab = UILabel(title: arr_one.get(at: index)?.desc, textColor: .color_333, blodSize: 16)
                                            if index == 0 {
                                                lab_temp_qq = lab
                                            }
                                            let lab_hint = UILabel(title: arr_one.get(at: index)?.hint, textColor: .color_aaa, fontSize: 11)
                                            flex.addItem(UIImageView(imageName: arr_one_img.get(at: index)!))
                                                .marginBottom(5)
                                                .width(50)
                                                .height(55)
                                            flex.addItem(lab).marginTop(5)
                                            flex.addItem(lab_hint)
                                            self.arr_lab_one.append(lab)
                                        }
                                    item_flex.view?.tag = 90 + index
                                    item_flex.view?.cx.addTapGesture(target: self, action: #selector(itemClick(sender: )))
                                    
                                    
                                }
                            }
                    }
                
                // 其他恢复服务
                flex.addItem()
                    .marginHorizontal(12)
                    .marginTop(10)
                    .width(Const.screenWidth - 24)
                    .backgroundColor(.white)
                    .cornerRadius(8)
                    .define { flex in
                        
                        flex.addItem()
                            .direction(.row)
                            .alignItems(.center)
                            .marginHorizontal(12)
                            .marginTop(16)
                            .define { flex in
//                                addFrontLine(flex: flex)
                                flex.addItem(lab_title_bottom)
                            }
                        
                        let width_item = ( Const.screenWidth - 30 ) / 4
                        flex.addItem().direction(.row)
                            .marginTop(10)
                            .justifyContent(.spaceBetween)
                            .wrap(.wrap)
                            .height(width_item * 2)
                            .define { flex in
                                (0..<arr_two.count).forEach { index in
                                    let  item_flex =  flex.addItem().direction(.column)
                                        .justifyContent(.center)
                                        .alignItems(.center)
                                        .width(width_item - 10)
                                        .height(width_item - 10)
                                        .define { flex in
                                            
                                            let lab = UILabel(title: arr_two.get(at: index)?.desc, textColor: .color_333, fontSize: 14)
                                            lab.textAlignment = .center
                                            lab.numberOfLines = 0
//                                            if index == 1 {
//                                                lab_temp_qq = lab
//                                            }
                                            flex.addItem(UIImageView(imageName: arr_two_img.get(at: index)!))
                                                .marginBottom(5)
                                                .size(30)
                                            flex.addItem(lab)
                                            self.arr_lab_two.append(lab)
                                        }
                                    item_flex.view?.tag = 100 + index
                                    item_flex.view?.cx.addTapGesture(target: self, action: #selector(itemClick(sender: )))
                                    
                                }
                            }
                    }
                
            }
        
        addSubview(v_root)
        
        GlobalModel.sub_refresh.subscribe(onNext: {[weak self] refresh in
            if refresh{
                for index in 0..<(self?.arr_lab_one.count ?? 0) {
                    let lab = self?.arr_lab_one.get(at: index)
                    lab?.text = self?.arr_one.get(at: index)?.desc
                }
                
                for index in 0..<(self?.arr_lab_two.count ?? 0) {
                    let lab = self?.arr_lab_two.get(at: index)
                    lab?.text = self?.arr_two.get(at: index)?.desc
                }
            }
        }).disposed(by: g_disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.all()
        v_root.flex.width(Const.screenWidth).layout(mode: .adjustHeight)
    }
    
    @objc func itemClick(sender: UITapGestureRecognizer) {
       
        guard  let tag = sender.view?.tag else { return }
        
        let vc = ServerDetailViewController()
        var item: Resp.ProductModel?
        if tag == 90 {
            item = getItem(type: GlobalModel.ProductType.WX_RECORD)
            vc.str_title = item?.productTypeText ?? GlobalModel.ProductType.WX_RECORD.desc
        } else if(tag == 91){
            item = getItem(type: GlobalModel.ProductType.WX_FRIEND)
            vc.str_title = item?.productTypeText ?? GlobalModel.ProductType.WX_FRIEND.desc
        }else if(tag == 92){
            vc.str_title = GlobalModel.ProductType.PHOTO.desc
            item = getItem(type: GlobalModel.ProductType.PHOTO)
        }else if(tag == 100){
            vc.str_title = GlobalModel.ProductType.MIC.desc
            item = getItem(type: GlobalModel.ProductType.MIC)
        }else if(tag == 101){
            item = getItem(type: GlobalModel.ProductType.QQ)
            vc.str_title =  item?.productTypeText ?? GlobalModel.ProductType.QQ.desc
        }else if(tag == 103){
            vc.str_title = GlobalModel.ProductType.MESSAGE.desc
            item = getItem(type: GlobalModel.ProductType.MESSAGE)
        } else if(tag == 102){
            vc.str_title = GlobalModel.ProductType.MEMO.desc
            item = getItem(type: GlobalModel.ProductType.MEMO)
        }else if(tag == 104){
            vc.str_title = GlobalModel.ProductType.WX_ORDER.desc
            item = getItem(type: GlobalModel.ProductType.WX_ORDER)
        }else if(tag == 105){
            vc.str_title = GlobalModel.ProductType.CALL.desc
            item = getItem(type: GlobalModel.ProductType.CALL)
        }else if(tag == 106){
            vc.str_title = GlobalModel.ProductType.SOFT.desc
            item = getItem(type: GlobalModel.ProductType.SOFT)
        }else if(tag == 107){
            vc.str_title = GlobalModel.ProductType.DEL.desc
            item = getItem(type: GlobalModel.ProductType.DEL)
        }
        vc.item = item
        self.target?.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func addFrontLine(flex:Flex){
        flex.addItem()
            .width(2)
            .height(12)
            .cornerRadius(1)
            .marginRight(5)
            .backgroundColor(.color_main)
    }
    
    
    /// 获取相应的模型数据
    /// - Parameter type: 类型
    /// - Returns: 模型数据
    fileprivate func getItem(type: GlobalModel.ProductType) -> Resp.ProductModel? {
        
        var item: Resp.ProductModel?
        let arr = GlobalModel.arr_product.filter { res in
            res.productType == type.rawValue
        }
        if arr.count > 0 {
            item = arr.first
        }
        
        return item
    }
}
