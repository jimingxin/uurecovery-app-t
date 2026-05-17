//
//  Network.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/9.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire


public class Network: NetworkProtocol {
    
    public static func cancelAllReqeust() {
        provider.session.session.getAllTasks { tasks in
            tasks.forEach { task in
                task.cancel()
            }
        }
    }
    
    
   public static let provider = MoyaProvider<TargetTypeManager>(configure: NetworkConfig.config)
}

public extension MoyaProvider {
    
    convenience init(configure: NetworkConfig) {
        
        let requestClosure = { (endpoint: Endpoint,
            done: @escaping MoyaProvider<TargetTypeManager>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                /// 设置请求超时时间
                request.timeoutInterval = configure.timeoutInterval
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }
        
        let endpointClosure = { (target :Target) -> Endpoint in

            guard let value = target as? TargetTypeManager,
                let headers = value.headers,
                headers.keys.count > 0 else {

                    return MoyaProvider.defaultEndpointMapping(for: target)
                    .adding(newHTTPHeaderFields: configure.headers)
            }

            // 如果自定义Header, 则使用自定义Header替换Configure的Header
            let headerSet = Set([String](headers.keys))
            let configHeaderSet = Set([String](configure.headers.keys))
            let differSet: Set<String> = headerSet.intersection(configHeaderSet)
            for key in differSet {
                if let value = headers[key] {
                    configure.headers.updateValue(value, forKey: key)
                }
            }
            return MoyaProvider.defaultEndpointMapping(for: target)
                           .adding(newHTTPHeaderFields: configure.headers)

        }
        
        
        // 加载证书
//        let certificates = Bundle.main.af.certificates

        // 配置证书信任策略
//        let serverTrustManager = ServerTrustManager(
//            evaluators: [
//                "youyou0112.com": PinnedCertificatesTrustEvaluator(
//                    certificates: certificates,
//                    acceptSelfSignedCertificates: true, // 不推荐开启
//                    performDefaultValidation: true,
//                    validateHost: true
//                )
//            ]
//        )
//        
//        let serverTrustManager = ServerTrustManager(evaluators: [
//            "youyou0112.com": DisabledTrustEvaluator()
//        ])

        
        // 创建自定义 Session
//        let session = Session(
//            serverTrustManager: serverTrustManager
//        )
        self.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            plugins: configure.plugins
        )
    }
}


