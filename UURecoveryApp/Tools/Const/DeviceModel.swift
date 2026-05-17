//
//  DeviceModel.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/3/15.
//

import Foundation

struct DeviceModel {
    // MARK: - 完整苹果设备型号数据库
    // iPhone型号对照表（按发布时间倒序）
    static let iPhoneIdentifiers: [String: String] = [
        /* 2024 */
        "iPhone17,3": "iPhone 16",
        "iPhone17,4": "iPhone 16 Plus",
        "iPhone17,1": "iPhone 16 Pro",
        "iPhone17,2": "iPhone 16 Pro Max",
        "iPhone17,5": "iPhone 16e",
        
        /* 2023 */
        "iPhone15,4": "iPhone 15",
        "iPhone15,5": "iPhone 15 Plus",
        "iPhone16,1": "iPhone 15 Pro",
        "iPhone16,2": "iPhone 15 Pro Max",
        
        /* 2022 */
        "iPhone14,7": "iPhone 14",
        "iPhone14,8": "iPhone 14 Plus",
        "iPhone15,2": "iPhone 14 Pro",
        "iPhone15,3": "iPhone 14 Pro Max",
        "iPhone14,6": "iPhone SE (3rd Gen)",
        
        /* 2021 */
        "iPhone14,4": "iPhone 13 mini",
        "iPhone14,5": "iPhone 13",
        "iPhone14,2": "iPhone 13 Pro",
        "iPhone14,3": "iPhone 13 Pro Max",
        
        /* 2020 */
        "iPhone12,8": "iPhone SE (2nd Gen)",
        "iPhone13,1": "iPhone 12 mini",
        "iPhone13,2": "iPhone 12",
        "iPhone13,3": "iPhone 12 Pro",
        "iPhone13,4": "iPhone 12 Pro Max",
        
        /* 2019 */
        "iPhone12,1": "iPhone 11",
        "iPhone12,3": "iPhone 11 Pro",
        "iPhone12,5": "iPhone 11 Pro Max",
        
        /* 2018 */
        "iPhone11,2": "iPhone XS",
        "iPhone11,4": "iPhone XS Max",
        "iPhone11,6": "iPhone XS Max (China)",
        "iPhone11,8": "iPhone XR",
        
        /* 2017 */
        "iPhone10,1": "iPhone 8",
        "iPhone10,4": "iPhone 8 (Global)",
        "iPhone10,2": "iPhone 8 Plus",
        "iPhone10,5": "iPhone 8 Plus (Global)",
        "iPhone10,3": "iPhone X",
        "iPhone10,6": "iPhone X (Global)",
        
        /* 2016 */
        "iPhone9,1": "iPhone 7",
        "iPhone9,3": "iPhone 7 (Global)",
        "iPhone9,2": "iPhone 7 Plus",
        "iPhone9,4": "iPhone 7 Plus (Global)",
        "iPhone8,4": "iPhone SE (1st Gen)",
        
        /* 2015 */
        "iPhone8,1": "iPhone 6s",
        "iPhone8,2": "iPhone 6s Plus",
        
        /* 2014 */
        "iPhone7,1": "iPhone 6 Plus",
        "iPhone7,2": "iPhone 6",
        
        /* 2013 */
        "iPhone6,1": "iPhone 5s",
        "iPhone6,2": "iPhone 5s (Global)",
        "iPhone5,3": "iPhone 5c",
        "iPhone5,4": "iPhone 5c (Global)",
        
        /* 2012 */
        "iPhone5,1": "iPhone 5",
        "iPhone5,2": "iPhone 5 (Global)",
        
        /* 2011 */
        "iPhone4,1": "iPhone 4s",
        
        /* 2010 */
        "iPhone3,1": "iPhone 4",
        "iPhone3,2": "iPhone 4 GSM Rev A",
        "iPhone3,3": "iPhone 4 CDMA",
        
        /* 2009 */
        "iPhone2,1": "iPhone 3GS",
        
        /* 2008 */
        "iPhone1,2": "iPhone 3G",
        
        /* 2007 */
        "iPhone1,1": "iPhone"
    ]

    // iPad型号对照表（按产品线分类）
    static let iPadIdentifiers: [String: String] = [
        "iPad16,5": "iPad Pro 13-inch (M4)",
        "iPad16,6": "iPad Pro 13-inch (M4)",
        /* iPad Pro */
        "iPad14,3": "iPad Pro 12.9-inch (6th Gen)",
        "iPad14,4": "iPad Pro 11-inch (4th Gen)",
        "iPad13,4": "iPad Pro 12.9-inch (5th Gen)",
        "iPad13,5": "iPad Pro 12.9-inch (5th Gen)",
        "iPad13,6": "iPad Pro 11-inch (3rd Gen)",
        "iPad13,7": "iPad Pro 11-inch (3rd Gen)",
        
        /* iPad Air */
        "iPad13,16": "iPad Air (5th Gen)",
        "iPad13,17": "iPad Air (5th Gen Cellular)",
        "iPad11,3": "iPad Air (3rd Gen)",
        "iPad11,4": "iPad Air (3rd Gen Cellular)",
        
        /* iPad mini */
        "iPad14,1": "iPad mini (6th Gen)",
        "iPad14,2": "iPad mini (6th Gen Cellular)",
        "iPad11,1": "iPad mini 5",
        "iPad11,2": "iPad mini 5 Cellular",
        
        /* 标准iPad */
        "iPad13,18": "iPad (10th Gen)",
        "iPad13,19": "iPad (10th Gen Cellular)",
        "iPad12,1": "iPad (9th Gen)",
        "iPad12,2": "iPad (9th Gen Cellular)",
        
        /* 历史型号 */
        "iPad1,1": "iPad (1st Gen)",
        "iPad2,1": "iPad 2 Wi-Fi",
        "iPad2,2": "iPad 2 GSM",
        "iPad2,3": "iPad 2 CDMA",
        "iPad2,4": "iPad 2 Wi-Fi Rev A",
        "iPad3,1": "iPad (3rd Gen) Wi-Fi",
        "iPad3,2": "iPad (3rd Gen) GSM",
        "iPad3,3": "iPad (3rd Gen) CDMA",
        "iPad3,4": "iPad (4th Gen) Wi-Fi",
        "iPad3,5": "iPad (4th Gen) GSM",
        "iPad3,6": "iPad (4th Gen) CDMA"
    ]

}

