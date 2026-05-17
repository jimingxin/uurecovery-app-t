//
//  WebViewController.swift
//  MXDataRecovery
//
//  Created by tineco on 2025/2/27.
//


import UIKit
import WebKit
import Kingfisher
import CXSwiftCommonModule

// 网页回调
public protocol WebViewProtocol {
    var delegate: Delegated<Any, Void> { get }
}

class WebViewController: BaseViewController, WebViewProtocol {
    
    static let webCallNative = "callPayAction"          // web 调用 Native
    static let nativeCallWeb = "getPayCallbackInfo"     // native 调用 web
    static let callJumpAction = "callJumpAction"

    // 页面类型
    @objc (PageType)
    enum PageType: Int {
        case base = 0   // 普通 web 页
        case shop = 1   // 商城页
    }
    
    var target: WebViewProtocol?            // 回调
    var delegate = Delegated<Any, Void>()   // 代理
    lazy var str_title = ""                 // 设置网页标题
    lazy var backEnable = false             // webView是否可返回
    lazy var closeEnable = false            // 是否显示可关闭的按钮
    lazy var forceBack = true              // 强制显示返回 - 用于区分 tab 中的商城
    lazy var right_icon: String = ""        // right item icon
    @objc var pageType: PageType = .base    // 当前页面类型
    lazy var shopPersonalCenterURL = ""     // 商城跳转个人中心 url
    lazy var str_right_title: String = ""   // right item title
    lazy var params: [String: String] = [:] // 网页参数
    
    // web url
    lazy var str_url: String = "" {
        didSet {
            if  let url = URL(string: handleUrl()) {
                let request = URLRequest(url: url)
                Asyncs.delay(0.3) {
                    let list = self.webView.backForwardList.backList
                    if list.count > 0 {
                        self.webView.go(to: list.first!)
                    } else {
                        self.webView.load(request)
                    }
                }
            }
        }
    }
    
    private lazy var configuration = WKWebViewConfiguration().then { config in
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        config.preferences = preferences
        config.selectionGranularity = .dynamic
        config.userContentController = WKUserContentController()
        config.userContentController.add(WeakMallScriptMessageDelegate(scriptDelegate: self), name: "callPayAction")
        config.userContentController.add(WeakMallScriptMessageDelegate(scriptDelegate: self), name: "callJumpAction")
    }
    
    // web view
    private lazy var webView = WKWebView(frame: CGRect(x: 0,
                                                       y: Const.navBarHeight,
                                                       width: Const.screenWidth,
                                                       height: Const.screenHeight - Const.navBarHeight - Const.bottomSafeHeight),
                                         configuration: configuration).then { web in
        web.backgroundColor = .color_f2f2f2
        web.navigationDelegate = self
        web.allowsBackForwardNavigationGestures = true
        web.scrollView.showsVerticalScrollIndicator = false
        web.scrollView.showsHorizontalScrollIndicator = false
    }
    
    deinit {
        debugPrint("\(type(of: self)) -- \(#function)")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "callPayAction")
        MBProgressHUD.yx_hudDismiss()
    }
}

// MARK: - base view controller
extension WebViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configNavigationBar() {
        self.cx.navigationBar?.title = str_title
        
        setCloseButton()
        
        self.cx.navigationBar?.removeLeftItemAction()
        
        self.cx.navigationBar?.leftItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
                if self?.webView.canGoBack ?? false {
                    self?.webView.evaluateJavaScript("callBackRouter()", completionHandler: { res, err in
                        if err != nil {
                            self?.webView.goBack()
                        }
                        self?.showRightButton()
                    })
                } else {
                    Router.pop()
                }
            })
            .disposed(by: disposeBag)
        
        switch pageType {
        case .base:
            setBaseRightItem()
            break
        case .shop:
            setShopRightButton()
            break
        }
    }
    
    override func baseConfig() {
        super.baseConfig()
        
    }
    
    @objc func backReload() {
        Asyncs.delay(0.3) {
            let list = self.webView.backForwardList.backList
            if list.count > 0 {
                self.webView.go(to: list.first!)
            }
        }
    }
    
    override func baseAddSubViews() {
        self.view.addSubview(webView)
    }
    
    override func baseAddConstraints() {
        var bottom = 0.0
        switch pageType {
        case .base:
            break
        case .shop:
            bottom = -Const.bottomTabBarHeight
            break
        }
        if forceBack {
            bottom = 0.0
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(Const.navBarHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(bottom)
        }
    }
    
    // MARK: - bindViewModel
    override func bindViewModel() {
        // 监听app进入前台
        NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .take(until: self.rx.deallocated)
            .subscribe { [weak self] (noti) in
                
                let str_js = "getPayCallbackInfo('{}')"
                self?.webView.evaluateJavaScript(str_js, completionHandler: { res, err in
                    
                })
            }.disposed(by: disposeBag)
        
        webView.rx.observe(String.self, "title")
            .distinctUntilChanged()
            .filter({ title in
                return title != "宝豆商城" && title != "" && title != "Title"
            })
            .subscribe(onNext: { [weak self] str in
                guard let this = self else {
                    return
                }
                
                if let title = str, title.count > 0 {
                    this.cx.navigationBar?.title = title
                    this.backEnable = this.forceBack
                    this.setLeftItem()
                }
            }).disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .distinctUntilChanged()
            .subscribe(onNext: { _ in
                // TODO: 设置网页的加载进度
            }).disposed(by: disposeBag)
        
    }
    
}

// MARK: - Private method
extension WebViewController {
    
    
    // MARK: - pay
    private func goToPay(res: [String: Any]) {
      
    }
    
    // MARK: - handle url
    private func handleUrl() -> String {
        var url_handle = str_url
        
        if params.count > 0 {
            if !url_handle.contains("?") {
                url_handle += "?"
            } else {
                url_handle += "&"
            }
            // 进行参数的拼接
            for (key,value) in params {
                url_handle += "\(key)=\(value)&"
            }
        }
        
        if url_handle.hasSuffix("&") {
            url_handle.removeLast()
        }
        
        return url_handle
    }
    
    // MARK: - tap gesture
    func handleNavigationTransition(tap: UIGestureRecognizer) {
        if webView.canGoBack {
            self.webView.evaluateJavaScript("callBackRouter()", completionHandler: { [weak self] res, err in
                if err != nil {
                    self?.webView.goBack()
                }
                self?.showRightButton()
            })
        } else {
            Router.pop()
        }
    }
    
    func setLeftItem() {
        self.cx.navigationBar?.leftItem.isHidden = !self.backEnable
        // 是否可以返回
        if self.backEnable {
            self.cx.navigationBar?.removeLeftItemAction()
            self.cx.navigationBar?.leftItem.setImage(UIImage(named: "common_icon_bg_color"), for: .normal)
        }
    }
    
    func setCloseButton() {
        // 添加关闭图标
        if self.closeEnable,
           let back = self.cx.navigationBar?.leftItem {
            let image = UIImage(named: "common_icon_bg_color")
            let butClose = UIButton(type: .custom)
            butClose.setImage(image, for: .normal)
            butClose.frame = CGRect(x: 40, y: Const.statusBarHeight + 2, width: back.cx.width, height: back.cx.height)
            
            cx.navigationBar?.addSubview(butClose)
            butClose.rx.tap
                .subscribe(onNext: {
                    Router.pop()
                })
                .disposed(by: disposeBag)
        }
    }
    
    func setBaseRightItem() {
        // 设置右边的按钮
        if str_right_title.count > 0 || right_icon.count > 0 {
            // 设置图标
            self.cx.navigationBar?.rightItem.setTitle(str_right_title, for: .normal)
            self.cx.navigationBar?.rightImage = right_icon
            self.cx.navigationBar?.rightItem.cx.x = Const.screenWidth - 80;
            self.cx.navigationBar?.rightItem.cx.width = 80;
            
            self.cx.navigationBar?.rightItem.rx.tap.subscribe(onNext: { [weak self] in
                self?.target?.delegate.call("")
            }).disposed(by: disposeBag)
        }
    }
    
    func setShopRightButton() {
        
    }
    
    
    // 是否显示导航右边按钮
    fileprivate func showRightButton() {
        if self.str_right_title.count > 0 {
            self.cx.navigationBar?.rightItem.isHidden = false
        } else {
            self.cx.navigationBar?.rightItem.isHidden = true
        }
    }
}

// MARK: - WKScriptMessageHandler callPayAction
extension WebViewController: WKScriptMessageHandler {
    /// 原生界面监听JS运行,截取JS中的对应在userContentController注册过的方法
    /// - Parameters:
    ///   - userContentController: WKUserContentController
    ///   - message: WKScriptMessage 其中包含方法名称已经传递的参数,WKScriptMessage,其中body可以接收的类型是Allowed types are NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("方法名:\(message.name)")
        debugPrint("参数:\(message.body)")
        
        if message.name == WebViewController.callJumpAction {
            guard let str_params = message.body as? String else {
                return
            }
            // type: .native 跳转本地页面, url 为本地页面名

            return
        }
        
        if message.name == WebViewController.webCallNative {
            guard let str_params = message.body as? String,
                  let params = Dictionary<String, Any>.converJSONStringToDic(json: str_params) else {
                      return
                  }

            // 唤起支付
            //self.goToPay(res: params)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        MBProgressHUD.yx_showLoding()
        return decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        self.progressView.isHidden = false
//        self.progressView.progress = 0.01
//        self.view.bringSubviewToFront(self.progressView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("网页加载成功")
        MBProgressHUD.yx_hudDismiss()
        Asyncs.delay(0.01) {
//            self.progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("网页加载失败")
        MBProgressHUD.yx_hudDismiss()
        Asyncs.delay(0.01) {
//            self.progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        MBProgressHUD.yx_hudDismiss()
        debugPrint("didFailProvisionalNavigation")
        Asyncs.delay(0.01) {
//            self.progressView.isHidden = true
        }
    }
}

extension WebViewController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if webView.canGoBack {
            webView.evaluateJavaScript("callBackRouter()", completionHandler: { res, err in
                if err != nil {
                    self.webView.goBack()
                }
                self.showRightButton()
            })
            return true
        } else {
            Router.pop()
            return false
        }
    }
}
