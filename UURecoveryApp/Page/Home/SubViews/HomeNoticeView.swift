//
//  HomeNoticeView.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/19.
//

import UIKit
import ZCycleView

class HomeNoticeView: BaseView {
    
    lazy var v_root = UIView();
    lazy var lab_title = UILabel.init(title: "公告", textColor: .color_333, fontSize: 15).then { lab in
        lab.font = Const.pingfang_MediumFont375(font: 12)
    }
    lazy var lab_user = UILabel.init(title: "", textColor: .color_666, fontSize: 12)
    lazy var lab_serve = UILabel.init(title: "", textColor: .hex("#698FF4"), fontSize: 12)
    lazy var lab_time = UILabel.init(title: "", textColor: .hex("#9AA8C5"), fontSize: 12).then { lab in
        lab.textAlignment = .right
    }
    
    private lazy var cycleView1: ZCycleView = {
        let width = Const.screenWidth - 20
        let cycleView1 = ZCycleView()
        cycleView1.scrollDirection = .vertical
        cycleView1.delegate = self
        cycleView1.reloadItemsCount(GlobalModel.arr_notice.count)
//        cycleView1.itemZoomScale = 1.2
//        cycleView1.itemSpacing = 30
//        cycleView1.initialIndex = 0
//        cycleView1.isAutomatic = true
//        cycleView1.isInfinite = true
        cycleView1.itemSize = CGSize(width: width - 30, height: 34)
        return cycleView1
    }()
    
    override func baseAddSubViews() {
        
        configData(isFirst: true)
        v_root.flex.direction(.row)
            .justifyContent(.spaceBetween)
            .alignItems(.center)
            .paddingHorizontal(10)
            .define { flex in
                flex.addItem(cycleView1).grow(1).height(34)
//                flex.addItem().direction(.row).alignItems(.center).define { flex in
//                    flex.addItem(UIImageView(imageName: "home_notice")).width(14).height(14).marginRight(5)
//                    flex.addItem(lab_title).width(50).size(44)
//                }
//                flex.addItem().direction(.row).justifyContent(.start).define { flex in
//                    flex.addItem(lab_user).minWidth(120)
//                    flex.addItem(lab_serve).grow(1)
//                }.grow(1)
//                flex.addItem(lab_time).width(80).height(100%).end(10)
            }
        
        addSubview(v_root)
    }
    
    override func baseConfig() {
        
        // 倒计时
//        Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
//            .subscribe {[weak self] _ in
//                
//                self?.configData()
//                self?.lab_user.flex.markDirty()
//                self?.lab_serve.flex.markDirty()
//                self?.lab_time.flex.markDirty()
//                
//            }.disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        v_root.pin.all().width(Const.screenWidth)
        
    }
    
    fileprivate func configData(isFirst: Bool = false) {
//        let count = GlobalModel.arr_notice.count
//        let ramdomInt = Int.random(in: 0..<count)
//        let data = GlobalModel.arr_notice.get(at: ramdomInt)!
//        lab_user.text = "\(data.phone)购买"
//        if isFirst == false {
//            lab_serve.text = "“\(data.server)”"
//        } else {
//            lab_serve.text = data.server.count > 6 ? "“\(data.server.substring(start: 0, 6))”" : "“\(data.server)”"
//        }
//        
//        lab_time.text = data.time
        
    }
    
}

// MARK: - ZCycleViewProtocol
extension HomeNoticeView : ZCycleViewProtocol {
    
    func cycleViewRegisterCellClasses() -> [String: AnyClass] {
        return ["HomeNoticeCollectionViewCell": HomeNoticeCollectionViewCell.self]
    }

    func cycleViewConfigureCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, realIndex: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeNoticeCollectionViewCell", for: indexPath) as! HomeNoticeCollectionViewCell
        let data = getNotice()
        cell.lab_desc.text = "\(data.phone)购买"
        cell.lab_service.text = "“\(data.server)”"
        cell.lab_time.text = "\(data.time)"
        return cell
    }
    
    func cycleViewDidScrollToIndex(_ cycleView: ZCycleView, index: Int) {
        
    }
    
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.isHidden = true
    
    }
    
    // 根据版本判断
    private func getNotice() -> GlobalModel.NoticeModel {
        if Tools.checkUpdate() {
            let count = GlobalModel.arr_notice.count
            let ramdomInt = Int.random(in: 0..<count)
            let data = GlobalModel.arr_notice.get(at: ramdomInt)!
            return data
        } else {
            let count = GlobalModel.arr_notice_two.count
            let ramdomInt = Int.random(in: 0..<count)
            let data = GlobalModel.arr_notice_two.get(at: ramdomInt)!
            return data
        }
        
    }
}



