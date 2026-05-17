//
//  HomeBaseView.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/18.
//

import UIKit
import JJCarouselView

class HomeBaseView: BaseView {
    
    weak var target:UIViewController?
    fileprivate let contentView = UIScrollView().then { sv in
        sv.showsVerticalScrollIndicator = false
    }
    fileprivate let rootFlexContainer = UIView()
    
    fileprivate let lab_title = UILabel(title: "UU数据恢复", textColor: .color_333, blodSize: 20).then { lab in
        lab.textAlignment = .center
    }
    
    fileprivate let iv_bg = UIImageView.init(imageName: "home_bg").then { iv in
        iv.contentMode = .scaleAspectFill
    }
    
    fileprivate let carouselView:JJCarouselView<UIImageView, UIImage> = JJCarouselView(frame: CGRect(x: 0, y: 0, width: Const.screenWidth, height: Const.adaptHeight(111)), initialize: nil);
    
    // 公告
    lazy var v_notice = HomeNoticeView()
    // 热门
    lazy var v_recoery = HomeRecoveryChildView().then { hb in
        hb.target = self.target;
    }
    // 介绍
    lazy var v_dis = HomeTeamView()
    
//        let arr_banner = ["home_banner_one", "home_banner_two", "home_banner_three"]
    var arr_banner = ["home_banner_one"]
    
    convenience init(isCon: Bool = true, vc: UIViewController?) {
        self.init(frame: .zero)
        target = vc
        
        if Tools.checkUpdate() {
            arr_banner = ["home_banner_one"]
        } else {
            arr_banner = ["home_banner_one", "home_banner_two", "home_banner_three"]
        }
        
        configCarouselView()
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(iv_bg)
                .width(Const.screenWidth)
                .aspectRatio(1.25)
                .position(.absolute)
            
            flex.addItem(lab_title)
                .width(Const.screenWidth)
                .marginTop(Const.statusBarHeight)
                .marginBottom(10)
            
            flex.addItem()
                .grow(1)
                .height(Const.adaptHeight(111))
                .define { flex in
                    flex.addItem(carouselView)
                }
            
            flex.addItem(v_notice)
                .height(Const.adaptHeight(34))
                .margin(10)
                .cornerRadius(Const.globalCorner)
                .backgroundColor(.white)
            
            flex.addItem(v_recoery)
            
            flex.addItem(v_dis).marginTop(10)
        }
        
        contentView.addSubview(rootFlexContainer)
        addSubview(contentView)
        
        contentView.delegate = self
        
        // 获取到版本号通知刷新
        GlobalModel.sub_refresh.subscribe(onNext: { [weak self] refresh in
            if refresh {
                self?.arr_banner = ["home_banner_one", "home_banner_two", "home_banner_three"]
                self?.carouselView.datas = self?.arr_banner.map({ str in
                    return UIImage(named: str)!
                }) ?? []
            }
            
        }).disposed(by: g_disposeBag)
        
        Asyncs.delay(1) {[weak self] in
            self?.contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Const.isIphoneX ? 0 : Const.tabBarHeight, right: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 使用 pin 进行布局
        contentView.pin.all()
        rootFlexContainer.pin.top().left().right()
        // 使用 flex 进行适配
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        // UIScrollView 进行大小适配
        contentView.contentSize = CGSize(width: rootFlexContainer.frame.size.width, height: rootFlexContainer.frame.size.height + Const.safeAreaHeight * 2);
        //        contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Const.bottomSafeHeight, right: 0)
    }
    
    
    /// 配置轮播图
    fileprivate func configCarouselView() {
        carouselView.config.display = { cell, object in
            cell.clipsToBounds = true
            cell.contentMode = .scaleAspectFill
            cell.image = object
        }
        carouselView.backgroundColor = UIColor.clear
        carouselView.event.onTap = { _, obj, idx in
            //              print(obj, idx)
        }
        carouselView.event.willMove = { idx in
            //              print("willMove----", idx)
        }
        carouselView.event.didMove = { idx in
            //              print("didMove----", idx)
        }
        carouselView.event.onScroll = { fromIndex, toIndex, progress in
            //            print("onScroll----", fromIndex, toIndex, progress)
        }
        carouselView.pageView.isHidden = true
        carouselView.pageView.alpha = 0
        carouselView.datas = arr_banner.map({ str in
            return UIImage(named: str)!
        })
    }
    
}

/**
 scroll的回调代理
 */
extension HomeBaseView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let vc = target else { return  }
        if scrollView.contentOffset.y > 64 {
            vc.cx.navigationBar?.title = "首页"
            
            UIView.animate(withDuration: 0.3) {
                vc.cx.navigationBar?.allBackgroundColor = .white
                vc.cx.navigationBar?.titleColor = .color_333
                vc.cx.navigationBar?.leftImage = "common_icon_bg_color"
            }
        } else {
            vc.cx.navigationBar?.title = ""
            UIView.animate(withDuration: 0.3) {
                vc.cx.navigationBar?.allBackgroundColor = .clear
                vc.cx.navigationBar?.titleColor = .white
                vc.cx.navigationBar?.leftImage = "back_white"
            }
        }
    }
}

