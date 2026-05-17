//
//  TabProvider.swift
//  CXSwiftCommonModule_Example
//
//  Created by tineco on 2025/2/13.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let arr_un_sel = ["homen","order","contact","mine"]
    let arr_sel = ["homen_1","order_1","contact_1","mine_1"]
    let arr_title = ["首页", "我的订单", "联系客服", "个人中心"]
    
    var curIndex = 0 {
        didSet {
            self.setSelectedImage(index: curIndex)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupCustomTabBar()
    }
    
    private func setupTabs() {
        let v1 = HomeViewController()
        let v2 = ContactViewController(isHiddenTab: false)
        let v3 = ServiceViewController()
        let v4 = MineViewController()
    
        
        v1.tabBarItem = ESTabBarItem.init(title: "首页", image: UIImage(named: "homen"), selectedImage: UIImage(named: "homen_1"))
        
        v3.tabBarItem = ESTabBarItem.init(title: "我的订单", image: UIImage(named: "order"), selectedImage: UIImage(named: "order_1"))
        v2.tabBarItem = ESTabBarItem.init(title: "联系客服", image: UIImage(named: "contact"), selectedImage: UIImage(named: "contact_1"))
        v4.tabBarItem = ESTabBarItem.init(title: "个人中心", image: UIImage(named: "mine"), selectedImage: UIImage(named: "mine_1"))
        
        let n1 = BaseNavigationController.init(rootViewController: v1)
        let n2 = BaseNavigationController.init(rootViewController: v2)
        let n3 = BaseNavigationController.init(rootViewController: v3)
        let n4 = BaseNavigationController.init(rootViewController: v4)
                
//        v1.cx.navigationBar?.title = "首页"
//        v2.cx.navigationBar?.title = "常见问题"
        v3.cx.navigationBar?.title = "订单"
//        v4.cx.navigationBar?.title = "我的"
        
            
            viewControllers =  [n1, n3,n2,n4]
        }

    private func setupCustomTabBar() {
        guard let items = tabBar.items else { return }
        
        // 设置未选中状态
        items.forEach { item in
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        }
        
        // 设置选中状态（使用大图标）
        setSelectedImage(index: selectedIndex)
        
        // 监听选中变化
        delegate = self
    }
    
    private func setSelectedImage(index: Int) {
        guard let items = tabBar.items, index < items.count else { return }
        
        // 1. 恢复所有item为未选中状态
        items.enumerated().forEach { i, item in
            
            let smallImage = UIImage.init(named: arr_un_sel[i])
            let title = arr_title[i]
            
            if #available(iOS 13.0, *) {
                item.image = smallImage?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular)).withRenderingMode(.alwaysOriginal)
            } else {
                item.image = smallImage?.withRenderingMode(.alwaysOriginal)
            }
            item.selectedImage = nil
            item.title = title
        }
        
        // 2. 设置选中item为大图标
        if index == 0 {
            if #available(iOS 13.0, *) {
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .bold)
                let image = UIImage(named: arr_sel[0])?.withConfiguration(largeConfig)
                items[index].selectedImage = image?.withRenderingMode(.alwaysOriginal)
            } else {
                let image = UIImage(named: arr_sel[0])
                items[index].selectedImage = image?.withRenderingMode(.alwaysOriginal)
            }
            
            // 3. 隐藏选中项文字
            items[index].title = nil
        } else {
            if #available(iOS 13.0, *) {
                let image = UIImage(named: arr_sel[index])?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
                items[index].selectedImage = image?.withRenderingMode(.alwaysOriginal)
                items[index].title = arr_title[index]
            } else {
                let image = UIImage(named: arr_sel[index])
                items[index].selectedImage = image?.withRenderingMode(.alwaysOriginal)
            }
            
        }

    }
}

// MARK: - UITabBarControllerDelegate
extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setSelectedImage(index: tabBarController.selectedIndex)
    }
}

enum TabProvider {
    
    
    static func tabbarWithNavigationStyle() -> UITabBarController {
        let tabBarController = CustomTabBarController()
        
        tabBarController.tabBar.backgroundColor = UIColor.white;
        setupTabBarAppearance()
        return tabBarController
    }

    // 在 AppDelegate 或 SceneDelegate 中全局设置
    static func setupTabBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            
            // 未选中状态文字属性
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.color_333,
                .font: UIFont.systemFont(ofSize: 10)
            ]
            
            // 选中状态文字属性
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.color_main,
                .font: UIFont.systemFont(ofSize: 10, weight: .bold)
            ]
            
            // 应用到所有 TabBar
            UITabBar.appearance().standardAppearance = appearance
            
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        } else {
            // iOS 13 以下备用方案
            UITabBarItem.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.color_333],
                for: .normal
            )
            UITabBarItem.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.color_main],
                for: .selected
            )
        }
    }

}


