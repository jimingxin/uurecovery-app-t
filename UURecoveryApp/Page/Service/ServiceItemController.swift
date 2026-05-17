//
//  ServiceItemController.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/21.
//

import UIKit
import JXSegmentedView
import RxSwift

class ServiceItemController: BaseIGListViewController, Refreshable {
   
    // 用于下拉刷新
    var refreshStatus = BehaviorSubject(value: RefreshStatus.initStatus)
    
    /**
     订单状态
     */
    enum PageType: String {
        case All = ""
        case CREATED = "CREATED"
        case PAID = "PAID"
        case COMPLETED = "COMPLETED"
        case CANCELLED = "CANCELLED"
    }

    // 当前订单类型
    var pageType: PageType = .All
    
    // 数据源
    var arr_ds: [Resp.OrderRespModel] = []
    
    var pageIndex = 1;
    
    var isInTab = true
    // 是否是本页面去支付
    var isToPay = false
    // 初始化
    init(pageType: PageType?) {
        if let type = pageType {
            self.pageType = type
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.isShowEmpty = true
        super.viewDidLoad()
        self.refreshStatus.onNext(.beingHeaderRefresh)
        Asyncs.delay(1) {[weak self] in
            if self!.isInTab {
                self?.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Const.isIphoneX ? 10 : Const.tabBarHeight + 10, right: 0)
            } else {
                self?.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
        }
    }
    
    override func baseAddConstraints() {
        
        if isInTab {
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(isInTab ? 0 : Const.navBarHeight)
                make.leading.trailing.equalToSuperview()
                
                make.bottom.equalToSuperview().offset(-Const.bottomTabBarHeight - Const.safeAreaHeight / 2)
            }
        } else {
            collectionView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(Const.navBarHeight)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset( -Const.safeAreaHeight)
            }
        }
        
    }
    
    override func baseConfig() {
        super.baseConfig()
        refreshStatusBind(scrollView: self.collectionView) { [weak self] in
            self?.refreshData()
        } footer: { [weak self] in
            self?.fetchList()
        }.disposed(by: disposeBag)

        // 通知刷新
        GlobalModel.sub_refresh_order
            .subscribe(onNext: {[weak self] _ in
                self?.refreshData()
        }).disposed(by: g_disposeBag)
    }
    
    
    /// 刷新数据
    fileprivate func refreshData(){
        self.arr_ds.removeAll()
        self.arr_ds = []
        self.pageIndex = 1;
        self.fetchList(isRefresh: true)
    }

}

// 获取网络数据
extension ServiceItemController {
    
    /// 获取数据的操作
    /// - Parameter isRefresh: 是否是刷新
    fileprivate func fetchList(isRefresh: Bool = false) {
        
        let params:[String: Any] = [
            "mobileId" :  GlobalModel.getDeviceID(),
            "memberMobile":GlobalModel.getLoginPhone(),
            "orderStatus": pageType.rawValue,
            "pageIndex": pageIndex,
            "pageRows": 10
        ]
        Network.request(
            method: .POST,
            path: API.DataRecovery.findUserOrderList.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: [Resp.OrderRespModel].self
        ).flatMapModel([Resp.OrderRespModel].self)
        .subscribe( onSuccess: { [weak self] res in
            
            guard let target = self else { return  }
            
            if res.count > 0 {
                if isRefresh {
                    target.arr_ds = res
                } else {
                    target.arr_ds.append(contentsOf: res)
                }
                target.pageIndex += 1
            }
            
            target.performUpdate()
            
            // 判断是否有数据了
            if isRefresh {
                target.refreshStatus.onNext(.endHeaderRefresh)
            } else {
                target.refreshStatus.onNext(.footerStatus(isHidden: false, isNoMoreData: res.count == 0))
            }
        }, onFailure: {[weak self] _ in
            guard let target = self else { return  }
            target.pageIndex = target.pageIndex - 1
            target.refreshStatus.onNext(.endHeaderRefresh)
            target.refreshStatus.onNext(.endFooterRefresh)
        }).disposed(by: disposeBag)
    }
    
}


/// 重写IGList相关的属性
extension ServiceItemController {
    
    override func listDataSource() -> [ListDiffable] {
        return arr_ds
        
    }
    
    override func sectionController(sectionModel: Any) -> ListSectionController {
        let section = CXIGBaseSectionController { context, index, mod in
            return ServiceItemCollectionViewCell.self
        } numOfItems: { context, mod in
            return 1
        } sizeForItem: { contex, index, mod in
            return CGSize(width: contex.containerSize.width, height: 215)
        } cellForItem: { [weak self] context, cell, index, mod in
            guard let itemCell = cell as? ServiceItemCollectionViewCell ,
                  let itemMod = mod as? Resp.OrderRespModel
            else {
                return
            }
            itemCell.setItemModel(itemMod, index: index)
            // 支付和取消订单
            itemCell.btn_action.rx.tap
                .take(until: itemCell.rx.prepareForReuse)
                .subscribe(onNext: { _ in
                self?.createOrder(item: mod as! Resp.OrderRespModel)
                }).disposed(by: itemCell.rx.reuseBag)
            
            itemCell.btn_cancel.rx.tap
                .take(until: itemCell.rx.prepareForReuse)
                .subscribe(onNext: { _ in
                self?.cancelOrder(item: mod as! Resp.OrderRespModel)
                }).disposed(by: itemCell.rx.reuseBag)
            
            itemCell.btn_link.rx.tap
                .take(until: itemCell.rx.prepareForReuse)
                .subscribe(onNext:{[weak self] _ in
                    self?.addLinkAction(model: itemMod)
                }).disposed(by: itemCell.rx.reuseBag)
        } didSelect: { context, index, mod in
            
        }
        return section
    }
   
}

extension ServiceItemController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

/**
 网络请求
 */
extension ServiceItemController {
    /**
     调用网络生成订单
     */
    fileprivate func createOrder(item: Resp.OrderRespModel) {
        
        MBProgressHUD.yx_showLoding(withMessage: "生成订单...")
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
            "memberMobile": GlobalModel.getLoginPhone(),
            "productType": item.productType,
            "serviceType": item.serviceType ,
            "orderNo": item.orderNo
        ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.getAlipayOrderStr.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Resp.CreateOrderRespModel.self
        ).flatMapModel(Resp.CreateOrderRespModel.self)
        .subscribe( onSuccess: { [weak self] res in
            MBProgressHUD.yx_hudDismiss()
            self?.openAliapyAction(mod: res)
        }, onFailure: { _ in
            MBProgressHUD.yx_hudDismiss()
        }).disposed(by: disposeBag)
    }
    
    
    /// 取消订单
    /// - Parameter item: 参数
    fileprivate func cancelOrder(item: Resp.OrderRespModel) {
        
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
            "orderNo": item.orderNo
        ]
        Network.request(
            method: .POST,
            path: API.DataRecovery.cancelOrder.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Any.self
        )
        .subscribe( onSuccess: { [weak self] res in
            if res.status == "S" {
                self?.refreshStatus.onNext(.beingHeaderRefresh)
                MBProgressHUD.yx_showMessage("订单取消成功")
            } else {
                MBProgressHUD.yx_showMessage("订单取消失败")
            }
            
        }, onFailure: { _ in
        }).disposed(by: disposeBag)
    }
    
    /**
     唤起支付宝支付
     */
    fileprivate func openAliapyAction(mod: Resp.CreateOrderRespModel) {
        if mod.orderNo.count > 0 {
            // 储存订单号
            userDefaults.set(mod.orderNo, for: MXDefaultKey.yy_order_no_paid)
        }
        isToPay = true
        AliPayManager.shared.payAlertController(self,
                                                request: mod.alipayOrderStr) { [weak self] in
            // 清空订单号
            userDefaults.set("", for: MXDefaultKey.yy_order_no_paid)
            if GlobalModel.sdkOnOff == "Y" {
                // 上报金额
                BDASignalManager.trackEssentialEvent(withName: kBDADSignalSDKEventPurchase,
                                                     params:["pay_amount": (mod.orderAmount.toInt() ?? 0) * 100])
            }
            
            if let isToPay = self?.isToPay, isToPay == false {
                return
            }
            self?.isToPay = false
            if let user = userDefaults.get(for: MXDefaultKey.userInfo),
                user.memberMobile.count > 0 {
                //
                MBProgressHUD.yx_showMessage("支付成功")
                self?.refreshStatus.onNext(.beingHeaderRefresh)
            } else {
                
                AlertPopupView.showInputView { phone, name in
                    self?.addOrderContact(phone: phone, name: name, mod: mod)
                } close: {
                    MBProgressHUD.yx_showMessage("稍后请再订单列表添加联系方式")
                    self?.refreshStatus.onNext(.beingHeaderRefresh)
                }
            }
            
        } payFail: {[weak self] in
            // 清空订单号
            userDefaults.set("", for: MXDefaultKey.yy_order_no_paid)
            MBProgressHUD.yx_showMessage("支付取消，请确认")
            self?.refreshStatus.onNext(.beingHeaderRefresh)
            
        }

    }
    
    
    /// 订单关联联系人
    /// - Parameter mod: 数据
    fileprivate func addLinkAction(model: Resp.OrderRespModel) {
        var mod = Resp.CreateOrderRespModel()
        mod.orderNo = model.orderNo
        // 添加联系人
        AlertPopupView.showInputView { [weak self] phone, name in
            self?.addOrderContact(phone: phone, name: name, mod: mod)
        } close: { 
        
        }
    }
    
    /// 绑定用户信息
    /// - Parameters:
    ///   - phone: 手机号
    ///   - name: 用户名
    ///   - mod: 订单信息
    fileprivate func addOrderContact(phone: String, name: String, mod: Resp.CreateOrderRespModel) {
        let params: [String:Any] = [
            "mobileId": GlobalModel.getDeviceID(),
            "orderNo": mod.orderNo,
            "contactPhone": phone,
            "contactName": name
        ]
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.addOrderContact.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: Any.self
        )
        .subscribe( onSuccess: {[weak self] res in
            if res.status == "S" {
                MBProgressHUD.yx_showMessage("绑定成功")
                self?.refreshStatus.onNext(.beingHeaderRefresh)
            } else {
                MBProgressHUD.yx_showMessage("绑定失败，请联系客服")
            }
        }, onFailure: { _ in
            MBProgressHUD.yx_showMessage("绑定失败，请联系客服")
        }).disposed(by: disposeBag)
    }
    
}

