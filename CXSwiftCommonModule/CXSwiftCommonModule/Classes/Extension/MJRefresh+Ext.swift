//
//  MJRefresh+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/5.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift



public enum RefreshStatus {
    case none
    case initStatus // 初始化状态
    case error
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case footerStatus(isHidden: Bool, isNoMoreData: Bool)
}

public extension UIScrollView {
    var cx_header: MJRefreshHeader {
        get { return mj_header! }
        set { mj_header = newValue }
    }
    var cx_footer: MJRefreshFooter {
        get { return mj_footer! }
        set { mj_footer = newValue }
    }
}

/// GIF下拉刷新
public class RefreshGifHeader: MJRefreshGifHeader {
    public override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
    
        
//        var arr = [UIImage]()
//        for index in 0...14 {
//            if let image = UIImage(named: "0000\(index)") {
//                arr.append(image)
//            }
//        }
//        setImages(arr, for: .idle)
//        setImages(arr, for: .pulling)
//        setImages(arr, for: .refreshing)
    }
}
public class RefreshNormalHeader: MJRefreshNormalHeader {
    public override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel?.isHidden = true
        isAutomaticallyChangeAlpha = true
    }
}

/// 上拉加载更多
public class RefreshBackNoramlFooter: MJRefreshBackNormalFooter {
    public override func prepare() {
        super.prepare()
        arrowView?.image = nil
    }
}

public protocol Refreshable {
    
    var refreshStatus: BehaviorSubject<RefreshStatus> { get }
}

public extension Refreshable {
    
    /// 刷新绑定
    /// - Parameters:
    ///   - scrollView: scrollView
    ///   - header: header
    ///   - footer: footer
    /// - Returns: Disposable
    func refreshStatusBind(scrollView: UIScrollView,
                           header: (() -> Void)? = nil,
                           footer: (() -> Void)? = nil) -> Disposable {
        if header != nil {
            scrollView.mj_header = RefreshNormalHeader {
                // 处理头部方法时结束尾部刷新。
                scrollView.mj_footer?.endRefreshing()
                header?()
            }
        }
        if footer != nil {
            scrollView.mj_footer = RefreshBackNoramlFooter {
                // 处理尾部方法时结束头部刷新。
                scrollView.mj_header?.endRefreshing()
                footer?()
            }
        }
        return refreshStatus.subscribe(onNext: { (status) in
            switch status {
            case .none:
                // 未发生任何状态事件时隐藏尾部。
                scrollView.mj_footer?.isHidden = true
            case .beingHeaderRefresh:
                scrollView.mj_header?.beginRefreshing()
            case .endHeaderRefresh:
                scrollView.mj_header?.endRefreshing()
            case .endFooterRefresh:
                scrollView.mj_footer?.endRefreshing()
            case .footerStatus(let isHidden, let isNone):
                // 根据关联值确定 footer 的状态。
                scrollView.mj_footer?.isHidden = isHidden
                // 处理尾部状态时，如果之前正在刷新头部，则结束刷新，
                // 至此，我们无需写判断结束头部刷新的代码，在这里自动处理。
                scrollView.mj_header?.endRefreshing()
                if isNone {
                    scrollView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    scrollView.mj_footer?.endRefreshing()
                }
            case .beingFooterRefresh:
                break
            case .initStatus:
                break
            case .error:
                scrollView.mj_footer?.endRefreshing()
                scrollView.mj_header?.endRefreshing()
            }
        })
    }
}




