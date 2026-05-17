//
//  AppDelegate.swift
//  CXSwiftCommonModule
//
//  Created by zainguo on 09/29/2020.
//  Copyright (c) 2020 zainguo. All rights reserved.
//

import UIKit
import CXSwiftCommonModule
import DefaultsKit
import Alamofire
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var rootController: UIViewController?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        // 获取网络请求
        checkNetwork(launchOptions: launchOptions)
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = TabProvider.tabbarWithNavigationStyle();
        self.rootController = vc
        self.window?.rootViewController = self.rootController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        debugPrint("-----applicationWillEnterForeground")
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        debugPrint("-----applicationDidBecomeActive")
        // 如果订单号不为空则继续操作
        guard let order = userDefaults.get(for: MXDefaultKey.yy_order_no_paid),
              order.count > 0 else {
            return
        }
        checkOrderPaidNOCallBack(order: order)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let openUrl = url.absoluteString
        BDASignalManager.anylyseDeeplinkClickid(withOpenUrl: openUrl)
        return true
    }
    
}


// MARK: - 支付回调
extension AppDelegate{
    // iOS 8 及以下请用这个
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.host == "safepay"{//支付宝
            //支付回调
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback:{ (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showResult(result:resultDic! as NSDictionary)
                }
            })
            //授权回调
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showAuth_V2Result(result:resultDic! as NSDictionary)
                }
            })
            return true
        }else{
            return false
        }
        
    }
    
    // iOS 9 以上请用这个
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.host == "safepay"{//支付宝
            //支付回调
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback:{ (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showResult(result:resultDic! as NSDictionary)
                }
            })
            //授权回调
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showAuth_V2Result(result:resultDic! as NSDictionary)
                }
            })
            return true
        }else{
            return false
        }
    }
}


/// 获取请求数据
extension AppDelegate {
    
    
    /// 监听网络
    fileprivate func checkNetwork(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let reachabilityManager = NetworkReachabilityManager.default
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            switch status {
            case .notReachable:
                print("没有网络连接")
            case .unknown :
                print("未知网络连接状态")
            case .reachable(.ethernetOrWiFi):
                fallthrough
            case .reachable(.cellular):
                self?.fetchAllAction(launchOptions: launchOptions)
            }
        })
    }
    
    
    fileprivate func fetchAllAction(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        // 巨量归因
        registerBDA(launchOptions: launchOptions)
        
        findVersion()
        // 激活APP
        activeApp()
        // 获取后台sdk开关
        findSdkOnOff()
        
        let _ =  GlobalModel.getDeviceID()
        
        if let arr =  userDefaults.get(for: MXDefaultKey.yy_products),
           arr.count > 0{
            GlobalModel.arr_product = arr
        }
        
        GlobalModel.arr_question = userDefaults.get(for: MXDefaultKey.yy_questions) ?? []
        // 获取 常见问题
        findAllQuestionList()
        // 获取 所有产品
        findAllProductList()
        
    }
    
    /**
     查询问题列表
     */
    fileprivate func findAllQuestionList() {
        
        Network.request(
            method: .POST,
            path: API.DataRecovery.findAllQuestionList.rawValue,
            encoding: .JSON,
            resultModel: [Resp.QuestionModel].self
        ).flatMapModel([Resp.QuestionModel].self)
            .subscribe( onSuccess: { res in
                GlobalModel.arr_question = res;
                // 缓存在本地
                if res.count > 0 {
                    userDefaults.set(res, for: MXDefaultKey.yy_questions);
                }
                
            }).disposed(by: g_disposeBag)
    }
    
    
    /// 获取所有的产品信息
    fileprivate func findAllProductList() {
        Network.request(
            method: .POST,
            path: API.DataRecovery.findAllProductList.rawValue,
            encoding: .JSON,
            resultModel: [Resp.ProductModel].self
        ).flatMapModel([Resp.ProductModel].self)
            .subscribe( onSuccess: { res in
                GlobalModel.arr_product = res;
                if res.count > 0 {
                    // 缓存在本地
                    userDefaults.set(res, for: MXDefaultKey.yy_products);
                }
                
            }).disposed(by: g_disposeBag)
    }
    
    fileprivate func findVersion() {
        Network.request(
            method: .POST,
            path: API.DataRecovery.findVersion.rawValue,
            encoding: .JSON,
            showErrorToast: false,
            resultModel: String.self
        ).flatMapModel(String.self)
            .subscribe( onSuccess: { res in
                if res.count > 0 {
                    // 缓存在本地
                    let version = userDefaults.get(for: MXDefaultKey.yy_version)
                    let appVersion = Tools.appVersion()
                    if  .none == version  ||  appVersion != res{
                        // 没有值，现在请求到值了
                        // 通知刷新
                        Asyncs.delay(0.1) {
                            GlobalModel.sub_refresh.onNext(Tools.checkUpdate() ? false : true)
                        }
                    }
                    userDefaults.set(res, for: MXDefaultKey.yy_version);
                }
            }).disposed(by: g_disposeBag)
    }
    
    
    /// App激活
    fileprivate func activeApp() {
        let params = [
            "mobileId": GlobalModel.getDeviceID(),
            "platform": "ios",
            "idfv": Tools.getIdfv()
        ]
        Network.request(
            method: .POST,
            path: API.DataRecovery.activeApp.rawValue,
            params: params,
            encoding: .JSON,
            showloaing: false,
            showErrorToast: false,
            resultModel: Any.self
        ).subscribe( onSuccess: { _ in
        }).disposed(by: g_disposeBag)
    }
    
    /// 获取后台是否打开上报
    fileprivate func findSdkOnOff() {
        Network.request(
            method: .POST,
            path: API.DataRecovery.findSdkOnOff.rawValue,
            encoding: .JSON,
            showErrorToast: false,
            resultModel: String.self)
        .flatMapModel(String.self)
        .subscribe( onSuccess: {  res in
            GlobalModel.sdkOnOff = res
            debugPrint("sdkOnOff ----  \(res)")
        }).disposed(by: g_disposeBag)
    }
    
    
    fileprivate func registerBDA(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // 注册可选参数
        BDASignalManager.register(withOptionalData: [:])
        //        BDASignalManager.enableIdfa(true)
        // 上报冷启动事件
        BDASignalManager.didFinishLaunching(options: launchOptions, connect: nil)
        
        Asyncs.delay(2) { [weak self] in
            // 激活
            self?.activeApp()
        }
        
    }
    
    /**
     支付宝支付后没有走正常的回调
     */
    fileprivate func checkOrderPaidNOCallBack(order: String) {
        let params:[String: Any] = [
            "mobileId" :  GlobalModel.getDeviceID(),
            "memberMobile":GlobalModel.getLoginPhone(),
            "orderStatus": ServiceItemController.PageType.PAID.rawValue,
            "pageIndex": 1,
            "pageRows": 10
        ]
        Network.request(
            method: .POST,
            path: API.DataRecovery.findUserOrderList.rawValue,
            params: params,
            encoding: .JSON,
            resultModel: [Resp.OrderRespModel].self
        ).flatMapModel([Resp.OrderRespModel].self)
            .subscribe( onSuccess: { res in
                if res.count == 0 {
                    return
                }
                let arr_filter =  res.filter { mod in
                    return mod.orderNo == order
                }
                
                guard let orderMod = arr_filter.get(at: 0) else { return }
                // 支付成功，之前没有上报，现在上报
                if orderMod.orderStatus == ServiceItemController.PageType.PAID.rawValue  {
                    // 清除
                    userDefaults.set("", for: MXDefaultKey.yy_order_no_paid)
                    if GlobalModel.sdkOnOff == "Y" {
                        // 上报金额
                        BDASignalManager.trackEssentialEvent(withName: kBDADSignalSDKEventPurchase,
                                                             params:["pay_amount": (orderMod.orderAmount.toInt() ?? 0) * 100])
                    }
                }
                
                
            }, onFailure: { _ in }).disposed(by: g_disposeBag)
    }
}



