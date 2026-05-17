//
//  BaseTeamView.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/20.
//

import UIKit

class HomeTeamView: BaseView {
    
    lazy var v_root = UIView();
    
    lazy var iv_bg = UIImageView.init(imageName: "home_about_bg").then { iv in
        iv.contentMode = .scaleAspectFill
    }
    
    lazy var lab_title = UILabel.init(title: "团队介绍", textColor: .color_333, fontSize: 16).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 16)
    }
    
    lazy var lab_pj = UILabel.init(title: "我们的评价", textColor: .color_main, fontSize: 16).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 18)
    }
    
    
    let str_about =  """
    UU数据恢复
    以10年线下技术沉淀为根基
    由专家级工程师1V1服务
    用技术筑牢数据安全防线
    
    
    无论是
    微信 / QQ 信息好友丢失，相册照片误删
    还是通讯录、备忘录内容消失
    亦或是磁盘误删、格式化、分区错乱
    均可精准找回，最大限度减少您的损失
    """
    
    let str_about_update =  """
    UU数据恢复
    以10年线下技术沉淀为根基
    由专家级工程师1V1服务
    用技术筑牢数据安全防线
    
    
    无论是
    聊天 / 企鹅 信息好友丢失，相册照片误删
    还是通讯录、备忘录内容消失
    亦或是磁盘误删、格式化、分区错乱
    均可精准找回，最大限度减少您的损失
    """
    
    
    let arr_img = ["home_ten","home_star","home_service"]
    
    var lab_about: UILabel?
    
    override func baseAddSubViews() {
        v_root
            .flex
            .direction(.column)
            .justifyContent(.center)
            .alignItems(.center)
            .marginHorizontal(0)
            .marginBottom(20)
            .backgroundColor(.white)
            .define { flex in
                
                flex.addItem()
                    .direction(.row)
                    .alignItems(.center)
                    .justifyContent(.center)
                    .marginVertical(20)
                    .define { flex in
                        flex.addItem(UIImageView.init(imageName: "about_icon"))
                            .width(12)
                            .height(12)
                            .marginRight(10)
                        flex.addItem(UILabel.init(title: "UU数据恢复", textColor: .color_333, blodSize: 12))
                    }
                
                flex.addItem()
                    .direction(.column)
                    .justifyContent(.center)
                    .alignItems(.center)
                    .define { [weak self] flex in
                        flex.addItem(UILabel.init(title: "UU数据恢复", textColor: .color_333, blodSize: 34))
                            .marginBottom(5)
                        flex.addItem(UILabel.init(title: "恢复的是数据，守护的是心安", textColor: .color_333, blodSize: 20))
                        
                        let str = self?.attriStr()
                        let lab = UILabel.init(title: "", textColor: .color_333, fontSize: 14).then { lab in
                            lab.font = Const.pingfang_RegularFont375(font: 14)
                            lab.textAlignment = .center
                            lab.numberOfLines = 0
                            lab.attributedText = str
                        }
                        self?.lab_about = lab
                        flex.addItem(lab)
                            .marginTop(20)
                            .width(Const.screenWidth - 40)
                    }
                
                
                flex.addItem(UIImageView(imageName: "about_team"))
                    .marginHorizontal(10)
                    .marginTop(20)
                    .width(Const.screenWidth - 40)
                    .aspectRatio(0.9)
                
                flex.addItem(UIImageView(imageName: "about_promise"))
                    .marginHorizontal(10)
                    .marginTop(20)
                    .width(Const.screenWidth - 40)
                    .aspectRatio(0.957)
                
                flex.addItem()
                    .direction(.row)
                    .justifyContent(.center)
                    .alignItems(.center)
                    .width(100%).define { flex in
                        flex.addItem(UIImageView(imageName: "home_line")).width(70).height(2)
                        flex.addItem(UILabel.init(title: "UU数据恢复的资质", textColor: .color_333, fontSize: 14))
                            .marginHorizontal(10)
                        flex.addItem(UIImageView(imageName: "home_line2")).width(70).height(2)
                        
                        
                    }
                
                createTeamZZBottomView(flex: flex)
                
                //                flex.addItem(lab_pj).marginVertical(15)
                //                flex.addItem().width(Const.screenWidth - 40)
                //                    .backgroundColor(.white)
                //                    .cornerRadius(5)
                //                    .marginTop(10)
                //                    .define { flex in
                //                        createTeamBottomView(flex: flex)
                //                    }
            }
        v_root.addSubview(iv_bg)
        v_root.sendSubviewToBack(iv_bg)
        v_root.clipsToBounds = true
        addSubview(v_root)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        v_root.pin.all()
        v_root.flex.width(Const.screenWidth).layout(mode: .adjustHeight)
        if v_root.cx.height > 0 {
            iv_bg.frame = v_root.bounds
        }
        
        GlobalModel.sub_refresh.subscribe(onNext: {[weak self] refresh in
            if refresh{
                self?.lab_about?.attributedText = self?.attriStr()
            }
        }).disposed(by: g_disposeBag)
    }
    
    
    fileprivate func addFrontLine(flex:Flex){
        flex.addItem()
            .width(2)
            .height(12)
            .cornerRadius(1)
            .marginRight(5)
            .backgroundColor(.color_main)
    }
    
    fileprivate func attriStr() -> NSAttributedString {
        var str = NSMutableAttributedString(string: Tools.checkUpdate() ? str_about_update : str_about)
        let str_temp = str_about as NSString
        
        str = str.colorRange(.color_main, range: str_temp.range(of: "10")) as! NSMutableAttributedString
        str = str.colorRange(.color_main, range: str_temp.range(of: "1V1")) as! NSMutableAttributedString
        return str
    }
}

extension HomeTeamView {
    fileprivate func createTeamBottomView(flex: Flex){
        flex.addItem().direction(.column)
            .padding(10)
            .width(100%).define { flex in
                creteTeamBottomItemView( flex: flex)
                    .marginVertical(10)
                creteTeamBottomItemView( flex: flex)
                    .cornerRadius(22)
                    .marginVertical(10)
                creteTeamBottomItemView( flex: flex)
                    .cornerRadius(22)
                    .marginVertical(10)
            }
    }
    
    fileprivate func creteTeamBottomItemView(flex: Flex) -> Flex{
        
        let lab_name = UILabel.init(title: "name", textColor: .color_333, fontSize: 14).then { lab in
            lab.font = Const.pingfang_MediumFont375(font: 15)
        }
        let lab_desc = UILabel.init(title: "添可好生活添可好生活添可好生活添可好生活添可好生活添可好生活",
                                    textColor: .color_333, fontSize: 12).then { lab in
            lab.numberOfLines = 0
        }
        
        return  flex.addItem().direction(.column).horizontally(10).define { flex in
            
            flex.addItem(lab_name).marginLeft(0).marginRight(10)
            flex.addItem().direction(.row).marginTop(5).define { flex in
                (0..<5).forEach { _ in
                    flex.addItem(UIImageView(imageName: "team-pj")).size(16).marginRight(3)
                }
            }
            flex.addItem(lab_desc).marginTop(5)
                .marginLeft(0).marginRight(20)
                .maxHeight(60)
                .layout(mode: .adjustHeight)
        }
        
    }
}
extension HomeTeamView {
    // 生成视图
    fileprivate func createTeamTopView(flex: Flex){
        flex.addItem().direction(.column).width(100%).define { flex in
            flex.addItem(creteTeamTopItemView( flex: flex,str: "十年线下技术团队"))
                .height(51)
                .cornerRadius(22)
                .marginVertical(5)
            flex.addItem(creteTeamTopItemView( flex: flex,str: "专家级数据恢复工程师", index: 1))
                .height(51)
                .cornerRadius(22)
                .marginVertical(5)
            flex.addItem(creteTeamTopItemView( flex: flex,str: "资深专家一对一高品质服务", index: 2))
                .height(51)
                .cornerRadius(22)
                .marginVertical(5)
        }
    }
    
    fileprivate func creteTeamTopItemView(flex: Flex,str: String, index: Int = 0)-> UIView{
        let view = UIImageView(imageName: "home_item_bg")
        let img = UIImageView(imageName: arr_img.get(at: index)!).then { iv in
            iv.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        let label = UILabel.init(title: str, textColor: .white, fontSize: 14)
        flex.addItem(view)
            .direction(.row)
            .justifyContent(.center)
            .alignItems(.center)
            .height(Const.widthRatio * 50)
            .define { flex in
                flex.addItem(img).size(25).marginTop(-8)
                flex.addItem(label).marginLeft(10).marginTop(-8)
            }
        return view
    }
}

extension HomeTeamView {
    fileprivate func createTeamZZBottomView(flex: Flex){
        
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
            .padding(10)
            .justifyContent(.center)
            .alignContent(.center)
            .wrap(.wrap)
            .width(100%).define { flex in
                flex.addItem(img_one).width(28%).height(140).margin(8)
                flex.addItem(img_two).width(28%).height(140).margin(8)
                flex.addItem(img_three).width(28%).height(140).margin(8)
            }
    }
}
