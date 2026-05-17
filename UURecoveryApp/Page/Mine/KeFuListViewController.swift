//
//  KeFuListViewController.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/8/19.
//

import UIKit

class KeFuListViewController: BaseIGListViewController,Refreshable {

    // 用于下拉刷新
    var refreshStatus = BehaviorSubject(value: RefreshStatus.initStatus)
    // 数据源
    var arr_ds: [Resp.CmrRespModel] = []
    
    var pageIndex = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cx.navigationBar?.title = "联系人工客服"
        self.refreshStatus.onNext(.beingHeaderRefresh)

    }
    
    
    override func baseAddConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Const.navBarHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset( -Const.safeAreaHeight)
        }
    }
    

    override func baseConfig() {
        super.baseConfig()
        refreshStatusBind(scrollView: self.collectionView,
                          header: { [weak self] in
            self?.refreshData(isRefresh: true)
        }).disposed(by: disposeBag)
        

    }
    
    /// 刷新数据
    fileprivate func refreshData(isRefresh: Bool){
        if isRefresh {
            self.arr_ds.removeAll()
            self.arr_ds = []
            self.pageIndex = 1;
            self.fetchList(isRefresh: true)
        } else {
            self.fetchList(isRefresh: false)
        }
        
    }

}

extension KeFuListViewController {
    /// 获取数据的操作
    /// - Parameter isRefresh: 是否是刷新
    fileprivate func fetchList(isRefresh: Bool = false) {
    
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
        ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.findAllCrmList.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: [Resp.CmrItemModel].self
        ).flatMapModel([Resp.CmrItemModel].self)
        .subscribe( onSuccess: { [weak self] res in
            
            guard let target = self else { return  }
            
            if res.count > 0 {
                let resp = Resp.CmrRespModel()
                resp.id = "KeFuListViewController"
                resp.data = res
                target.arr_ds = [resp]
            }
            
            target.reloadData()
            // 判断是否有数据了
            target.refreshStatus.onNext(.footerStatus(isHidden: false, isNoMoreData: res.count == 0))

        }, onFailure: {[weak self] _ in
            guard let target = self else { return  }
            target.pageIndex = target.pageIndex - 1
            target.refreshStatus.onNext(.endHeaderRefresh)
            target.refreshStatus.onNext(.endFooterRefresh)
        }).disposed(by: disposeBag)
    }
}


/// 重写IGList相关的属性
extension KeFuListViewController {
    override func listDataSource() -> [ListDiffable] {
        return arr_ds
        
    }
    
    override func sectionController(sectionModel: Any) -> ListSectionController {
        let section = KeFuListSectionController()
        section.target = self
        return section
    }
   
}
