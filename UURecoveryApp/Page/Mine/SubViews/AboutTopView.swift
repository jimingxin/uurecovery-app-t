//
//  AboutTopView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/24.
//

import UIKit

class AboutTopView: BaseView {
    
    lazy var v_root = UIView();
    
    lazy var lab_title = UILabel.init(title: "关于我们", textColor: .color_main, fontSize: 16).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 18)
    }
    
//    lazy var lab_pj = UILabel.init(title: "我们的资质", textColor: .color_main, fontSize: 16).then { lab in
//        lab.font = Const.pingfang_MediumFont375(font: 18)
//    }
//    
    
    let str_one = "凡通过本公司平台没能恢复成功，且通过其他渠道成功恢复的，凭相关恢复成功凭证，本公司绝对保证给您双倍赔付，并免费赠送数据恢复全套服务"
    
    lazy var lab_one = UILabel.init(title: str_one, textColor: .color_333, fontSize: 14).then { lab in
        lab.numberOfLines = 0
    }
    let str_three = "我们拥有数十位技术精湛的研发团队和恢复工程师，专注于移动设备和电脑设备的数据恢复服务，为个人用户和企业用户提供数据咨询服务和解决方法，全心全意打造满意服务，让客户可以安全.高效的找回自己的数据"
    
    lazy var lab_three = UILabel.init(title: str_three, textColor: .color_333, fontSize: 14).then { lab in
        lab.numberOfLines = 0
    }
    
    override func baseAddSubViews() {
        v_root.flex.direction(.column).justifyContent(.center).alignItems(.center).paddingHorizontal(10).define { flex in
            
            // 优优的数据恢复
            flex.addItem()
                .marginHorizontal(20)
                .position(.relative)
                .top(-45)
                .define { flex in
                createOne(flex: flex)
            }
            
            // 优优数据恢复保障
            flex.addItem()
                .marginHorizontal(20)
                .marginTop(-20)
                .define { flex in
                createtwo(flex: flex)
            }
            
            // 优优数据恢复专业团队
            flex.addItem()
                .marginHorizontal(20)
                .top(20)
                .define { flex in
                createThree(flex: flex)
            }
    
            
        }
        
        addSubview(v_root)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.all()
        v_root.flex.width(Const.screenWidth).layout(mode: .adjustHeight)
    }
    
}


/**
 优优数据恢复承诺
 */
extension AboutTopView {
    
    fileprivate func createOne(flex: Flex) {
        flex.addItem()
            .width(Const.screenWidth - 40)
            .define { flex in
                flex.addItem()
                    .alignItems(.end)
                    .define {
                        flex in
                        let lab = UILabel(title: "优优数据恢复承诺", textColor: .color_333, fontSize: 20).then { lab in
                            lab.font = Const.pingfang_MediumFont375(font: 20)
                        }
                        flex.addItem(lab).marginBottom(4)
                        flex.addItem(UILabel(title: "commitments".uppercased(), textColor: .hex("#9AA8C5"), fontSize: 10))
                    }
            }
        flex.addItem(lab_one).marginTop(10).marginBottom(6)
        flex.addItem(UIImageView(imageName: "mine_about_one"))
            .width(Const.screenWidth - 40)
            .aspectRatio(2.75)
    }
}


/**
 中间我们的资质
 */
extension AboutTopView {
    
    fileprivate func createtwo(flex: Flex) {
        flex.addItem()
            .width(Const.screenWidth - 40)
            .define { flex in
                flex.addItem()
                    .alignItems(.start)
                    .define {
                        flex in
                        let lab = UILabel(title: "优优数据恢复保障", textColor: .color_333, fontSize: 20).then { lab in
                            lab.font = Const.pingfang_MediumFont375(font: 20)
                        }
                        flex.addItem(lab).marginBottom(4)
                        flex.addItem(UILabel(title: "qualification".uppercased(), textColor: .hex("#9AA8C5"), fontSize: 10))
                    }
            }
        createZZView(flex: flex)
        flex.addItem(UIImageView(imageName: "mine_about_two"))
            .width(Const.screenWidth - 40)
            .aspectRatio(2.75)
    }
    /**
     生成我们的资质
     */
    fileprivate func createZZView(flex: Flex){
                
        let img_one = UIImageView(imageName: "yy_one").then { iv in
            iv.contentMode = .scaleAspectFit
        }
        let img_two = UIImageView(imageName: "yy_two").then { iv in
            iv.contentMode = .scaleAspectFit
        }
        let img_three = UIImageView(imageName: "yy_three").then { iv in
            iv.contentMode = .scaleAspectFit
        }
        
        flex.addItem().direction(.row)
            .justifyContent(.spaceBetween)
            .alignContent(.center)
            .wrap(.wrap)
            .marginTop(10)
            .width(Const.screenWidth - 40)
            .define { flex in
                flex.addItem(img_one)
                    .width(31%)
                    .height(140)
                    .marginBottom(10)
                
                flex.addItem(img_two)
                    .width(31%)
                    .height(140)
                    .marginBottom(10)
                    
                flex.addItem(img_three)
                    .width(31%)
                    .height(140)
                    .marginBottom(10)
                    
                
            }
        
    }
    
    //    fileprivate func creteTeamBottomItemView(flex: Flex) -> Flex{
    //
    //        let lab_name = UILabel.init(title: "name", textColor: .color_333, fontSize: 14).then { lab in
    //            lab.font = Const.pingfang_MediumFont375(font: 15)
    //        }
    //        let lab_desc = UILabel.init(title: "添可好生活添可好生活添可好生活添可好生活添可好生活添可好生活",
    //                                    textColor: .color_333, fontSize: 12).then { lab in
    //            lab.numberOfLines = 0
    //        }
    //
    //        return  flex.addItem().direction(.column).horizontally(10).define { flex in
    //
    //            flex.addItem(lab_name).marginLeft(0).marginRight(10)
    //            flex.addItem().direction(.row).marginTop(5).define { flex in
    //                (0..<5).forEach { _ in
    //                    flex.addItem(UIImageView(imageName: "team-pj")).size(16).marginRight(3)
    //                }
    //            }
    //            flex.addItem(lab_desc).marginTop(5)
    //                .marginLeft(0).marginRight(20)
    //                .maxHeight(60)
    //                .layout(mode: .adjustHeight)
    //        }
    //
    //    }
}

/**
 优优数据恢复专业团队
 */
extension AboutTopView {
    
    fileprivate func createThree(flex: Flex) {
        flex.addItem()
            .width(Const.screenWidth - 40)
            .define { flex in
                flex.addItem()
                    .alignItems(.end)
                    .define {
                        flex in
                        let lab = UILabel(title: "优优数据恢复专业团队", textColor: .color_333, fontSize: 20).then { lab in
                            lab.font = Const.pingfang_MediumFont375(font: 20)
                        }
                        flex.addItem(lab).marginBottom(4)
                        flex.addItem(UILabel(title: "professional team".uppercased(), textColor: .hex("#9AA8C5"), fontSize: 10))
                    }
            }
        flex.addItem(lab_three).marginTop(10).marginBottom(6)
        flex.addItem(UIImageView(imageName: "mine_about_four"))
            .width(Const.screenWidth - 40)
            .aspectRatio(2.75)
    }
}



//extension AboutTopView {
//    // 生成视图
//    fileprivate func createAboutTopView(flex: Flex){
//        flex.addItem().direction(.row).width(100%).define { flex in
//            flex.addItem(createAboutTopItemView( flex: flex,str: "行业领先"))
//                .grow(1)
//            flex.addItem().width(1).height(45).marginTop(30).backgroundColor(.color_8a8a)
//            flex.addItem(createAboutTopItemView( flex: flex,str: "资源优质"))
//                .grow(1)
//            flex.addItem().width(1).height(45).marginTop(30).backgroundColor(.color_8a8a)
//            flex.addItem(createAboutTopItemView( flex: flex,str: "团队专业"))
//                .grow(1)
//        }
//    }
//
//    fileprivate func createAboutTopItemView(flex: Flex,str: String)-> UIView{
//        let view = UIView()
//        let img = UIImageView(imageName: "team-sure").then { iv in
//            iv.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        }
//        let label = UILabel.init(title: str, textColor: .color_333, fontSize: 15)
//        flex.addItem(view).direction(.column).justifyContent(.center).alignItems(.center)
//            .define { flex in
//                flex.addItem(img).size(30).marginTop(20)
//                flex.addItem(label).marginTop(Const.padding)
//            }
//        return view
//    }
//}
