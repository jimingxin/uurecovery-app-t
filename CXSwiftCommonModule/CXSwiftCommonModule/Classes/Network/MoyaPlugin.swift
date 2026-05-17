//
//  MoyaPlugin.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/10.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import Moya

let networkActivityPlugin = NetworkActivityPlugin { (change, _) in
    switch(change){
    case .ended:
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    case .began:
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
}

public class RequestLogPlugin: PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? TargetTypeManager else { return request }
        if target.showloding {
            DispatchQueue.main.async {
                HUD.showLoading()
            }
        }
        return request
    }
    public func willSend(_ request: RequestType, target: TargetType) {
        let netRequest = request.request
        if let url = netRequest?.description,
           NetworkConfig.config.logEnable {
            debugPrint("✅✅✅" + url)
        }
        if let httpMethod = netRequest?.httpMethod,
           NetworkConfig.config.logEnable {
            debugPrint("✅✅✅ Method: \(httpMethod)")
        }
        if let body = netRequest?.httpBody,
           let output = String(data: body, encoding: .utf8) {
            debugPrint("✅✅✅ Body:\(output)")
        }
        if let header = netRequest?.allHTTPHeaderFields,
           NetworkConfig.config.logEnable {
            debugPrint("✅✅✅ Header:\(header)")
        }
       
    }
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        switch result {
        case .success(let response):
            let request_url = target.baseURL.appendingPathComponent(target.path)
            if NetworkConfig.config.logEnable {
                debugPrint("😘😘😘 \(request_url)")
            }
            if let data = try? response.mapString(),
               NetworkConfig.config.logEnable {
                debugPrint("😘😘😘 Return Response:")
                debugPrint("😘😘😘 \(data)")
                debugPrint("😘😘😘")

            } else {
                if NetworkConfig.config.logEnable {
                    debugPrint("❌❌❌ Can not formatter data")
                    debugPrint("❌❌❌")
                }
            }
        case .failure(let error):
            if NetworkConfig.config.logEnable {
                debugPrint("❌❌❌ \(error.errorDescription ?? "没有错误描述")") }
        }
    }
}
