//
//  NetworkConfig.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/12.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import Moya

@objcMembers
public class NetworkConfig: NSObject {
    
    public static let config = NetworkConfig()
    /// 超时时间
    public var timeoutInterval: TimeInterval = 30
    /// 插件
    public var plugins: [PluginType] = [RequestLogPlugin(), networkActivityPlugin]
    /// 请求头
    public var headers: [String: String] = [:]
    /// 日志输出
    public var logEnable: Bool = true
}

