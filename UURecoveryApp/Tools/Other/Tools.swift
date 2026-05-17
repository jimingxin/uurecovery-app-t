//
//  Tools.swift
//  CXMerchant
//
//  Created by jimingxin on 2020/10/21.
//  Copyright © 2020 zainguo. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import UIKit
import DefaultsKit


public struct Tools {
    
    static var IDFV: String = ""
    
    static func appBuild() -> String? {
        if let info = Bundle.main.infoDictionary {
            let appBuild = info[kCFBundleVersionKey as String] as? String
            return appBuild
        }
        return nil
    }
    
    
    static func appVersion() -> String? {
        if let info = Bundle.main.infoDictionary {
            let appVersion = info["CFBundleShortVersionString"] as? String
            return appVersion
        }
        return nil
    }
    
    // 后台的版本
    static func netVersion() -> String? {
        let version = userDefaults.get(for: MXDefaultKey.yy_version)
        return version
    }
    
    
    /// 比较版本号大小
    /// - Returns: 描述
    static func checkUpdate() -> Bool {
        let appVersion = appVersion() ?? "99999999"
        let netVersion = netVersion() ?? "0"
        let v_app = versionStringToInt(appVersion) ?? 0
        let v_net = versionStringToInt(netVersion) ?? 0
        if v_app > v_net { // 在审核需要
            return true
        }
        return false
    }
    
    /// 判断定位权限
    /// - Returns: true false
    static func locationValidated() ->Bool {
        if CLLocationManager.locationServicesEnabled() && (
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .notDetermined ||
            CLLocationManager.authorizationStatus() == .authorizedAlways
        ) {
            return true
        }
        
        return false
    }
    
    /// 验证是否允许定位
    /// - Returns:
    static func validMerchantLocation() -> Bool {
        
        return true
    }
    
    
    
    /// 是否需要更新
    /// - Returns: true 需要更新 false 不需要更新
    static func versionUpdate() -> Bool {
        guard  let currentBuildVersion = Tools.appBuild()?.toInt(),
               let build = userDefaults.get(for: MXDefaultKey.appBuild)?.toInt() else {
                   return false
               }
        
        if build > currentBuildVersion  {
            return true
        }
        return false
    }
    
    
    /// 相册权限
    /// - Returns: 是否有访问相册权限
    static func checkPhotoAuthority() -> Bool {
        
        guard PrivatePermission.checkPhoto() == true else {
            AlertView.show(message: "我们需要您的同意才能访问相册，请在“设置－隐私－相册”中允许使用",
                           leftItemTitle: "取消",
                           rightItemTitle: "确定",
                           leftItemBlock: nil,
                           rightItemBlock: { _ in
                
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            })
            return false
        }
        return true
    }
    
    
    
    /// 检测通知权限
    /// - Parameter complete: 回调通知权限
    static func checkNotificationAuthority(complete: @escaping (Bool)->()) {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                complete(true)
                return
            }
            complete(false)
            
        }
    }
    
    
    /// 打开应用设置
    @discardableResult
    static func goToAppSettings() -> Bool {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return true
        }
        return false
    }
    
    /// 过滤器 将.2f格式化的字符串，去除末尾0
    ///
    /// - Parameter numberString: .2f格式化后的字符串
    /// - Returns: 去除末尾0之后的
    static func removeSuffix(numberString : String) -> String {
        
        if numberString.count > 1 {
            let strs = numberString.components(separatedBy: ".")
            guard let last = strs.last else { return "" }
            
            if strs.count == 2 {
                
                var tempStr = numberString
                if last == "00" {
                    
                    let indexEndOfText      = numberString.index(numberString.endIndex, offsetBy:-3)
                    tempStr = String(numberString[..<indexEndOfText])
                    
                } else {
                    
                    let indexStartOfText    = numberString.index(numberString.endIndex, offsetBy:-1)
                    let str                 = numberString[indexStartOfText...]
                    let indexEndOfText      = numberString.index(numberString.endIndex, offsetBy:-1)
                    if str == "0" {
                        tempStr = String(numberString[..<indexEndOfText])
                    }
                    
                }
                
                if tempStr.hasSuffix(".") {
                    tempStr = String(tempStr.substring(start: 0, tempStr.count - 1))
                }
                return tempStr
            }
            
            return numberString
            
        } else {
            return ""
        }
    }
    
    /// 移除指定nav控制器的子控制器
    /// - Parameters:
    ///   - nav: 导航控制器
    ///   - cls: 控制器
    static func navRemoveChild(nav: UINavigationController?, cls: AnyClass) {
        // 移除控制器
        nav?.viewControllers.removeAll(where: { $0.classForCoder == cls })
    }
    
    
    /// 返回列表空白的视图
    /// - Parameters:
    ///   - image: 空白页的图片显示
    ///   - title: 标题
    /// - Returns: 空白视图
    static func emptyView(image: UIImage? = UIImage(named: "nodata"), titles: [UILabel] = []) -> UIView {
        let empty = UIView().then { (v) in
            let iv = UIImageView(image: image).then { (iv) in
                iv.contentMode = .scaleAspectFit
            }
            
            let stack = UIStackView(arrangedSubviews: titles)
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            
            
            v.addSubview(iv)
            v.addSubview(stack)
            
            iv.snp.makeConstraints { (make) in
                make.width.equalToSuperview().multipliedBy(0.3)
                make.top.equalTo(80 + Const.realNavBarHeight)
                make.centerX.equalToSuperview()
            }
            
            stack.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(iv.snp.bottom).offset(-20)
                make.height.equalTo(30)
            }
        }
        
        return empty
        
    }
    
    
    /// 计算cell的实际大小
    /// - Parameters:
    ///   - rect: 容器大小
    ///   - colCount: 列数
    ///   - space: 间隙
    /// - Returns: item的宽度
    static func fixItemWith(rect : inout CGRect, colCount: CGFloat, space: CGFloat) -> CGFloat {
        let totalSpace = (colCount - 1) * space
        let itemWidth = (rect.width - totalSpace) / colCount
        let fixValue = 1 / UIScreen.main.scale
        var realItemWidth = floor(itemWidth) + fixValue;
        if realItemWidth < itemWidth {
            realItemWidth += fixValue
        }
        
        let realWidth = colCount * realItemWidth + totalSpace
        let pointX = (realWidth - rect.width) / 2
        rect.origin.x = -pointX
        rect.size.width = realWidth
        return realItemWidth
    }
    
    /// 设置手机号安全显示
    /// - Parameter str: 手机号
    /// - Returns: 安全的手机号
    static func phoneSecureAction(str: String) -> String {
        var str_temp = str
        return  str_temp.cx.replaceStingWithRange(range: 3...6, replacText: "****")
    }
    
    /**
     版本号转
     */
    static func versionStringToInt(_ version: String) -> Int? {
        let components = version.components(separatedBy: ".")
        var parts: [Int] = []
        
        // 将每个部分转换为非负整数
        for component in components {
            guard let part = Int(component), part >= 0 else {
                return nil
            }
            parts.append(part)
        }
        
        var sum = 0
        var multiplier = 1
        
        // 逆序处理各部分以计算总和
        for part in parts.reversed() {
            // 计算当前部分的值并检查溢出
            let product = part.multipliedReportingOverflow(by: multiplier)
            guard !product.overflow else { return nil }
            
            // 累加到总和并检查溢出
            let newSum = sum.addingReportingOverflow(product.partialValue)
            guard !newSum.overflow else { return nil }
            sum = newSum.partialValue
            
            // 更新乘数以准备下一个部分，并检查溢出
            let newMultiplier = multiplier.multipliedReportingOverflow(by: 1000)
            guard !newMultiplier.overflow else { return nil }
            multiplier = newMultiplier.partialValue
        }
        
        return sum
    }
    
}

// MARK: - extension Tools
extension Tools {
    
    
    /// 设置空白的占位图和文字
    /// - Parameters:
    ///   - scrollView: 需要设置的scrollView
    ///   - lab: 文字
    ///   - img: 图片
    static func configScrollViewEmpty(scrollView: UIScrollView, lab: String, img: UIImage? = nil) {
//        scrollView.cx_emptyView.titleStr = lab
//        if let icon = img {
//            scrollView.cx_emptyView.image = icon
//        }
//        
//        scrollView.cx_emptyView.contentViewOffset = -30
    }
    
    
    static func notificationPost(name: String, object: Any? = nil) {
        // 通知页面刷新
        NotificationCenter.default.post(name: NSNotification.Name(name), object: object)
    }
    
    
    /// 根据identifier获取controller
    /// - Parameters:
    ///   - vc: 控制器
    ///   - sb: storyboard
    /// - Returns: 控制器实例
    static func storyBoardVC(vc: String, sb: String = "Main") -> UIViewController? {
        
        let sb = UIStoryboard(name: sb, bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: vc)
        
        return vc
        
    }
    
    
    
    /// 从本地plist文件中读取内容
    /// - Returns: 读取的数据
    static func decodePropertyList(filepath: String) -> Any? {
        
        let result = NSMutableArray(contentsOfFile: filepath)
        return result
    }
    
    
    /// 生成UUID
    /// - Returns: 返回生成好的UUID
    static func getUUIDString() -> String {
        let newUUID = UUID()
        return newUUID.uuidString
    }
    
    
    /// 获取具体的设备型号
    /// - Returns: 返回具体信息
    static func getDeviceModel()-> String {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        
        var machine = Array<CChar>(repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    /// 获取具体的设备名称
    /// - Returns: 返回具体信息
    static func getDeviceName()-> String {
        let mode = getDeviceModel()
        let map = DeviceModel.iPhoneIdentifiers + DeviceModel.iPadIdentifiers
        let name = map[mode]
        if let deviceName = name {
            return deviceName
        } else {
            return mode
        }
    }
    
    
    /// 获取IDFV
    /// - Returns: 返回IDFV
    static func getIdfv() -> String{
        
        var idfv = Tools.IDFV
        if idfv.count > 0 {
            return idfv
        } else {
            idfv =  UIDevice.current.identifierForVendor?.uuidString ?? ""
            Tools.IDFV = idfv
        }
        return Tools.IDFV
    }
    
}


extension Double {
    func  withoutZero()-> String {
        let value = String(format: "%.2f", self)
        let str_withoutZero = Tools.removeSuffix(numberString: value)
        return str_withoutZero
        
    }
    
}


extension NSLayoutConstraint {
    /// 设置约束的优先级
    func setPriority(priority: Float) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem ?? NSNull(),
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = UILayoutPriority(priority)
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}




// 先定义运算符重载（放在全局作用域）
func + <K, V>(left: [K: V], right: [K: V]) -> [K: V] {
    return left.merging(right) { $1 } // 冲突时取右值
}

