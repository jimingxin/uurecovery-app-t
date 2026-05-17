//
//  BaseIGViewController.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/10/12.
//  Copyright © 2020 zainguo. All rights reserved.
//

import UIKit
import IGListKit

@objcMembers public class BaseIGListViewController: BaseViewController {

    // 是否显示空占位图
    lazy var isShowEmpty = false {
        didSet {
            debugPrint("------")
        }
    }
    
    lazy var collectionView: UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        coll.backgroundColor = .bg_color
        coll.showsVerticalScrollIndicator = false 
        return coll
    }()

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        adapter.collectionView = self.collectionView
        return adapter
    }()

    /// 初始化的时候， viewDidLoad就刷新 之前写，用于一开始是否刷新
    lazy var refresh_init = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension BaseIGListViewController {

    public override func baseAddSubViews() {
        view.addSubview(self.collectionView)
    }

    public override func baseAddConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Const.navBarHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Const.bottomSafeHeight)
        }
    }

    public override func baseConfig() {
        if refresh_init {
            adapter.dataSource = self
        }
    }
}

extension BaseIGListViewController {
    func sectionController(sectionModel: Any) -> ListSectionController {
        return ListSectionController()
    }

    func listDataSource() -> [ListDiffable] {
        return []
    }

    func emptyViewForCollectionView() -> UIView? {

        view.layoutIfNeeded()
        let v = Tools.emptyView()
        return v
    }
    
    
    /// 列表刷新操作
    /// - Parameters:
    ///   - showEpmty: 是否显示无数据UI
    ///   - animated: 是否动画
    ///   - completion: 回调操作
    func performUpdate(showEpmty: Bool = true ,animated: Bool = true, completion: ListUpdaterCompletion? = nil ) {
        isShowEmpty = showEpmty
        adapter.performUpdates(animated: animated, completion: completion)
    }
    
    
    /// 整体重新加载数据
    /// - Parameters:
    ///   - showEpmty: 是否显示无数据UI
    ///   - completion: 回调操作
    func reloadData(showEpmty: Bool = true , completion: ListUpdaterCompletion? = nil ) {
        isShowEmpty = showEpmty
        adapter.reloadData(completion: completion)
    }
}

// MARK: IGListKit代理回调
extension BaseIGListViewController: ListAdapterDataSource {
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return listDataSource()
    }

    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return sectionController(sectionModel: object)
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        if isShowEmpty {
            return emptyViewForCollectionView()
        } else {
            return nil
        }
        
    }
}

