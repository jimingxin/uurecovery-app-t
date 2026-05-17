//
//  NetwokProtocol.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/12.
//  Copyright © 2020 canshi. All rights reserved.
//

import Foundation
import RxSwift
import Moya


public protocol NetworkProtocol {
    
    static func baseRequest(base: String,
                            method: APIRequestMethod,
                            path: String,
                            params: [String: Any]?,
                            headers:[String: String]?,
                            encoding: APIEncodingType,
                            showloaing: Bool) -> Single<Moya.Response>
    
    static func baseUploadImages(base: String,
                                 url: String,
                                 params: [String: Any]?,
                                 headers: [String: String]?,
                                 name: String,
                                 images: [UIImage],
                                 fileNames: [String]?,
                                 mimeTypes: [String]?,
                                 showloading: Bool) -> Single<Moya.Response>
    
    static func cancelAllReqeust()
}

extension NetworkProtocol {
    
    ///  GET / POST 网络请求
    /// - Parameters:
    ///   - base: 域名
    ///   - method: 请求方法
    ///   - path: url
    ///   - params: 请求参数
    ///   - headers: 请求头
    ///   - encoding: 编码方式
    ///   - showloaing: 是否需要加载loading
    /// - Returns: Single
    public static func baseRequest(base: String,
                                   method: APIRequestMethod,
                                   path: String,
                                   params: [String: Any]?,
                                   headers:[String: String]?,
                                   encoding: APIEncodingType = .URL,
                                   showloaing: Bool = false) -> Single<Moya.Response> {
        
        let config = APIConfig(encodingType: encoding,
                               method: method,
                               baseURL: base,
                               path: path,
                               params: params,
                               headers: headers,
                               showloding: showloaing)
        
        return Network.provider.rx
            .request(.request(config))
            .filterSuccessfulStatusCodes()
        
    }
    /// 图片上传
    /// - Parameters:
    ///   - base: 域名
    ///   - url: url
    ///   - params: 请求参数
    ///   - headers: 请求头
    ///   - name: name
    ///   - images: image数组
    ///   - fileNames: 文件名
    ///   - mimeTypes: 图片类型
    ///   - showloading: 是否需要加载loading
    /// - Returns: Sigle
    
    public static func baseUploadImages(base: String,
                                        url: String,
                                        params: [String : Any]? = [:],
                                        headers: [String : String]? = [:],
                                        name: String,
                                        images: [UIImage],
                                        fileNames: [String]? = [],
                                        mimeTypes: [String]? = [],
                                        showloading: Bool = true) -> Single<Response> {
        
        var uploadImages = [UploadImage]()
        
        for (index, image) in images.enumerated() {
            var imageType: String = "jpg"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
            
            var imageFileName = formatter.string(from: Date()) + "\(index).jpg"
            
            if let imageTypes = mimeTypes, imageTypes.count > 0 {
                imageType = imageTypes[index]
            }
            
            if let imageFileNames = fileNames, imageFileNames.count > 0 {
                imageFileName = imageFileNames[index] + "." + imageType
            }
            let uploadImage = UploadImage(image: image,
                                          name: name,
                                          fileName: imageFileName,
                                          mimeType: imageType)
            uploadImages.append(uploadImage)
        }
        let config = UploadConfig(baseURL: base,
                                  path: url,
                                  params: params,
                                  headers: headers,
                                  showloding: showloading,
                                  images: uploadImages,
                                  files: [])
        
        return Network.provider.rx
            .request(.upload(config))
            .filterSuccessfulStatusAndRedirectCodes()
    }
}
