//
//  KeFuListSectionController.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/8/19.
//

import UIKit

class KeFuListSectionController: ListSectionController {

    weak var target:UIViewController?
    var model: Resp.CmrRespModel?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0,
                             left: Const.padding,
                             bottom: Const.realNavBarHeight + 10,
                             right: Const.padding)
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.supplementaryViewSource = self
    }
    
    
    override func numberOfItems() -> Int {
        guard let mod = model else { return 0 }
        return mod.data.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: Const.screenWidth, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: KeFuListSectionItemCell.self, for: self, at: index) as? KeFuListSectionItemCell, let mod = model?.data.get(at: index) else {
            return UICollectionViewCell()
        }
        cell.setItemModel(mod, index: index)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let item = model?.data.get(at: index) else { return  }
        
        if item.openStatus != "Y" {
            MBProgressHUD.yx_showMessage("您还没有下单！下单后可联系工程师进行恢复")
            return
        }
        
        let mod_sync = userDefaults.get(for: MXDefaultKey.yy_kefu_mod)
        if index == 0 {
            // 默认客服直接跳转
            goToWeb(url: item.crmUrl, title: item.crmName)
        } else {
            
            if let mod = mod_sync {
                // 跳转到客服页面
                MBProgressHUD.yx_showMessage("打开之前联系过的工程师客服")
                goToWeb(url: mod.crmUrl, title: mod.crmName)
                return
            }
            
            if index > 0 {
                userDefaults.set(item, for: MXDefaultKey.yy_kefu_mod);
            }
            // 跳转到客服页面
            goToWeb(url: item.crmUrl, title: item.crmName)
        }
        
    }
    
    override func didUpdate(to object: Any) {
        guard let mod = object as? Resp.CmrRespModel else {
            return
        }
        model = mod
    }
    
    /// 跳转到网页
    /// - Parameter url: url地址
    private func goToWeb(url: String, title:String = "Title") {
        let vc =  WebViewController()
        vc.str_url = url
        vc.backEnable = true
        vc.str_title = title
        target?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension KeFuListSectionController: ListSupplementaryViewSource{
    
    func supportedElementKinds() -> [String] {
        guard let count = self.model?.data.count, count > 0 else {
            return []
        }
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        
        
        guard let header = collectionContext?.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            for: self,
            class: KeFuListSectionHeader.self,
            at: index
        ) as? KeFuListSectionHeader else {
            return UICollectionViewCell()
        }

        return header
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        guard let count = self.model?.data.count, count > 0 else {
            return CGSize.zero
        }
        return CGSize(width:  Const.screenWidth - Const.padding * 2, height: 200)
    }
}
