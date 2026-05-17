//
//  ServerSelectView.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/9.
//  选择套餐服务

import UIKit
import ZCycleView

class ServerSelectView: BaseView {
    
    typealias ServerCallBack = (Int) -> Void
    
    var callBack: ServerCallBack?
    
    var item: Resp.ProductModel?
    
    let images = [UIImage(named: "ser_zhuanye"),
                  UIImage(named: "ser_normal")]

    private lazy var cycleView: ZCycleView = {
        let width = Const.screenWidth - 20
        let cycleView1 = ZCycleView()
        cycleView1.scrollDirection = .horizontal
        cycleView1.delegate = self
        cycleView1.reloadItemsCount(2)
        cycleView1.itemZoomScale = 1.2
        cycleView1.itemSpacing = 40
        cycleView1.initialIndex = 0
        cycleView1.isAutomatic = false
        cycleView1.isInfinite = false
        cycleView1.itemSize = CGSize(width: width - 120, height: (width - 120) / 1.9625)
        return cycleView1
    }()
    
    override func baseAddSubViews() {
        addSubview(cycleView)
    }
    
    override func baseAddConstraints() {
        cycleView.snp.makeConstraints {
            $0.left.equalTo(0)
            $0.top.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(cycleView.snp.width).dividedBy(1.9625)
        }
    }

}


extension ServerSelectView : ZCycleViewProtocol{
    func cycleViewRegisterCellClasses() -> [String: AnyClass] {
        return ["CustomCollectionViewCell": CustomCollectionViewCell.self]
    }

    func cycleViewConfigureCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, realIndex: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.imageView.image = images[realIndex]
        if let temp = item {
            cell.configData(item: temp, isNormal: realIndex == 1)
        }
        
        return cell
    }
    
    func cycleViewDidScrollToIndex(_ cycleView: ZCycleView, index: Int) {
        
        if let cb = callBack {
            cb(index)
        }
        
    }
    
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.isHidden = true
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .green
        pageControl.frame = CGRect(x: 0, y: cycleView.bounds.height-25, width: cycleView.bounds.width, height: 25)
    }
}
