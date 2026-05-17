//
//  PrivatePermission.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/22.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit
import Photos


public class PrivatePermission {
    
    public enum PhotoPermissionType {
        /// 已经获取到了
        case geted
        /// 没有权限 or 其他情况
        case other
    }
}


public extension PrivatePermission {
    
    /// 主动获取摄像头权限 系统会主动弹出提示框
    class func getVideoPermission(status: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (statu) in
            status(statu)
        }
    }
    
    /// 主动获取麦克风权限 系统会主动弹出提示框
    class func getAudioPermission(status: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio) { (statu) in
            status(statu)
        }
    }
    
    /// 获取相册的写状态权限 如果从未获取过会主动去获取,状态通过闭包返回 如果曾经获取过了会通过闭包返回对应的状态
    class func getPhotoPermission(statuBlock: @escaping (PhotoPermissionType) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:   //已经获取到权限
            statuBlock(.geted)
        case .notDetermined:    //从未获取过权限
            PHPhotoLibrary.requestAuthorization({ (requestStatus) in
                if requestStatus == .authorized {
                    statuBlock(.geted)
                }else{
                    statuBlock(.other)
                }
            })
        default:
            statuBlock(.other)
        }
    }
    
    /// 获取定位权限
    class func getLocationPermission(statuBlock: (Bool) -> Void) {
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined || status == .restricted || status == .denied {
            statuBlock(false)
        } else {
            statuBlock(true)
        }
    }
}

// MARK: - ================ checkPermissions ================

public extension PrivatePermission {
    /// 检查当前相机、相册、麦克风权限
    ///
    /// - Returns: 是否获取全部权限
    class func checkPermissions() -> Bool{
        return checkVideo() && checkPhoto() && checkAudio()
    }
    
    /// 检查相机权限
    ///
    /// - Returns: 是否获得权限
    class func checkVideo() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /// 检查相册权限
    ///
    /// - Returns: 是否获得权限
    class func checkPhoto() -> Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    /// 检查麦克风权限
    ///
    /// - Returns: 是否获得权限
    class func checkAudio() -> Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .authorized:
            return true
        default:
            return false
        }
    }
    class func checkLocationIsGet() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined || status == .restricted || status == .denied {
            return false
        } else {
            return true
        }
    }
    
}
