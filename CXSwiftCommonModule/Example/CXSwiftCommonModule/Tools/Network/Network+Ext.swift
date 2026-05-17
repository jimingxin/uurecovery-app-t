//
//  Network+Ext.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/10.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import RxSwift
import KakaJSON
import Moya

public extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    
    func mapCode() -> Single<Response> {
        
        return flatMap { response in
            
            guard let model = response.data.kj.model(Network.Response.self) else {
                return .create { single -> Disposable in
                    let error = Network.Error.status(code: response.statusCode,
                                                     message: "Json解析错误",
                                                     showloading: true)
                    single(.failure(error))
                    return Disposables.create()
                }
            }
            
            if model.success {
                return Single.just(response)
            }
            let error = Network.Error.status(code: model.code,
                                             message: model.message,
                                             showloading: false)
            switch model.code {
            case 1002:
                fallthrough
            case 1006...1008:
                if let absoluteURL = response.request?.url?.absoluteURL.absoluteString, false {
                    // 不进行处理,用于切换账号有弹框,我的页面也会调用这个接口
                } else {
                    // token过期
                    
                    return Single.error(error)
                }
                break
            case 1017:
                // 查询数据为空
                fallthrough
            case 1120:
                // 微信认证, 汇潮渠道
                // 清除本地微信认证
                userDefaults.clear(.showWXAuth)
                fallthrough
            case 1216:
                // 账号更换成功: /openapi/merchant/base/home
                fallthrough
            case 1044:
                // 提现/转账密码为空, 设置密码
                fallthrough
            case 1094:
                // 指定银行
                fallthrough
            case 9999:
                // 身份证OCR识别
                fallthrough
            case 1089:
                // 1089: 不支持此卡
                return Single.error(error)
            case 1043:
                // 保存用户信息, 等待后台审核
                HUD.showToast(title: model.message)
                return Single.just(response)
            default:
                break
            }
            
            return .create { single -> Disposable in
                let error = Network.Error.status(code: model.code,
                                                 message: model.message,
                                                 showloading: true)
                single(.failure(error))
                return Disposables.create()
            }
        }
    }
    
    
}

// MARK: - 扩展模型解析
extension PrimitiveSequenceType where Trait == SingleTrait {
    func flatMapModel<R>(_ type: R.Type) -> Single<R> {
        return flatMap { resp in
            guard let res = resp as? Network.ResponseModel<R>,
                  let result = res.result else {
                return  Single.error(Network.fastError(msg: "json解析错误"))
            }
            return Single.just(result)
        }
    }
}

 extension Network {
    
    
    /// 网络请求GET / POST
    /// - Parameters:
    ///   - base: 域名
    ///   - method: 请求方法默认GET
    ///   - path: url
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - encoding: 编码方式默认URL
    ///   - showloaing: 是否显示加载loading
    /// - Returns: Single<Moya.Response>
    static func request(base: String? = API.baseURL,
                        method: APIRequestMethod = .GET,
                        path: String,
                        params: [String: Any]? = [:],
                        headers: [String: String]? = [:],
                        encoding: APIEncodingType? = .URL,
                        showloaing: Bool? = false,
                        showErrorToast: Bool? = true ) -> Single<Moya.Response> {
        
        return baseRequest(base: base!,
                           method: method,
                           path: path,
                           params: params,
                           headers: headers,
                           encoding: encoding!,
                           showloaing: showloaing!)
            .mapCode()
            .do(onSuccess: { (response) in
                HUD.hidden()
            }, onError: { error in
                var api_path = "";
                #if DEBUG
                    api_path = "\(path) --> "
                #endif
                guard let e = error as? Network.Error else {
                    guard let err = error as? Moya.MoyaError,
                       case Moya.MoyaError.statusCode(let resp) = err,
                       let str = String(data: resp.data, encoding: String.Encoding.utf8) else {
                        return showErrorToast == true ? HUD.showToast(title: "\(api_path)\(error.localizedDescription)") : ()
                    }
                    
                    if let dic = Dictionary<String, Any>.converJSONStringToDic(json: str),
                       let str_err = dic["error"] as? String {
                        return showErrorToast == true ? HUD.showToast(title: "\(api_path)\(str_err)" ) : ()
                    } else {
                        return showErrorToast == true ? HUD.showToast(title: "\(api_path)\(str)" ) : ()
                    }
                }
                if e.showloading == false || showErrorToast == false {
                    HUD.hidden()
                    return
                }
                
                HUD.showToast(title: "\(api_path)\(e.message)")
            })
    }
    
    /// 网络请求返回模型
    /// - Parameters:
    ///   - base: 域名
    ///   - method: 请求方法默认GET
    ///   - path: url
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - encoding: 编码方式默认URL
    ///   - showloaing: 是否显示加载loading
    ///   - resultModel: ResponseModel
    /// - Returns: model
    static func request<Result>(base: String? = API.baseURL,
                                             method: APIRequestMethod = .GET,
                                             path: String,
                                             params: [String: Any]? = [:],
                                             headers: [String: String]? = [:],
                                             encoding: APIEncodingType? = .URL,
                                             showloaing: Bool? = false,
                                             showErrorToast: Bool? = true,
                                             resultModel: Result.Type) -> Single<ResponseModel<Result>> {
        
        return baseRequest(base: base!,
                           method: method,
                           path: path,
                           params: params,
                           headers: headers,
                           encoding: encoding!,
                           showloaing: showloaing!)
            .mapCode()
            .mapObject(ResponseModel<Result>.self)
            .do(onSuccess: { (response) in
                HUD.hidden()
            }, onError: { error in
                var api_path = "";
                #if DEBUG
                    api_path = "\(path) --> "
                #endif
                guard let e = error as? Network.Error else {
                    guard let err = error as? Moya.MoyaError,
                       case Moya.MoyaError.statusCode(let resp) = err,
                       let str = String(data: resp.data, encoding: String.Encoding.utf8) else {
                        return showErrorToast == true ? HUD.showToast(title: "\(api_path)\(error.localizedDescription)") : ()
                    }
                    
                    if let dic = Dictionary<String, Any>.converJSONStringToDic(json: str),
                       let str_err = dic["error"] as? String {
                        return showErrorToast == true ? HUD.showToast(title: "\(api_path)\(str_err)" ) : ()
                    } else {
                        return showErrorToast == true ? HUD.showToast(title: "\(api_path)\(str)" ) : ()
                    }
                }
                if e.showloading == false || showErrorToast == false {
                    HUD.hidden()
                    return
                }
                
                HUD.showToast(title: "\(api_path)\(e.message)")
            })
    }
    
    static func uploadImages(base: String = API.baseURL,
                             url: String,
                             params: [String : Any]? = [:],
                             headers: [String : String]? = [:],
                             name: String,
                             images: [UIImage],
                             fileNames: [String]? = [],
                             mimeTypes: [String]? = [],
                             showloading: Bool = true) -> Single<Moya.Response> {
        
        return baseUploadImages(base: base,
                                url: url,
                                params: params,
                                headers: headers,
                                name: name,
                                images: images,
                                fileNames: fileNames,
                                mimeTypes:mimeTypes,
                                showloading: showloading)
            .do(onSuccess: { (response) in
                HUD.hidden()
                debugPrint("😝😝")
                
            }, onError: { error in
                HUD.hidden()
                debugPrint(error.localizedDescription)
            })
        
    }
}
