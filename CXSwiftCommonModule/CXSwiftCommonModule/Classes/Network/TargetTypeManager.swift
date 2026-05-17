//
//  TargetTypeManager.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/9.
//  Copyright © 2020 canshi. All rights reserved.
//

import Moya
import RxSwift

public protocol TargetTypeProtocol {
    /// 是否显示loding
    var showloding: Bool { get }
}

public protocol CaixinTargetType: TargetType, TargetTypeProtocol {}

public enum TargetTypeManager {
    case request(APIConfig)
    case upload(UploadConfig)
}


extension TargetTypeManager: CaixinTargetType {
   
    public var baseURL: URL {
        switch self {
        case .request(let config):
            return URL(string: config.baseURL)!
        case .upload(let upload):
            return URL(string: upload.baseURL)!
        }
    }

    public var path: String {
        switch self {
        case .request(let config):
            return config.path
        case .upload(let upload):
            return upload.path
        }
    }

    public var method: Moya.Method {
        switch self {
        case .request(let config):
            switch config.method {
            case .GET:
                return .get
            case .POST:
                return .post
            }
        case .upload(_):
            return .post
        }
    }

    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

   
    public var task: Task {
        switch self {
        case .request(let config):

            guard let paramts = config.params else {
                return .requestPlain
            }
            if config.encodingType == .URL {
                return .requestParameters(parameters: paramts, encoding: URLEncoding.default)
            }
            return .requestParameters(parameters: paramts, encoding: JSONEncoding.default)
        case .upload(let upload):
            return uploadTask(upload)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .request(let config):
            return config.headers
        case .upload(let upload):
            return upload.headers
        }
    }

    public var showloding: Bool {
        switch self {
        case .request(let config):
            return config.showloding
        case .upload(let upload):
            return upload.showloding
        }
    }
}

extension TargetTypeManager {

    func uploadTask(_ uploadConfig: UploadConfig) -> Task {

        var formDataArray = [MultipartFormData]()
        if let images = uploadConfig.images {
            for image in images {
                if let data = image.image.jpegData(compressionQuality: 1) {
                    let formData = MultipartFormData(provider: .data(data),
                                                     name: image.name,
                                                     fileName: image.fileName,
                                                     mimeType: image.mimeType)
                    formDataArray.append(formData)
                }
            }
        }

        if let files = uploadConfig.files {
            for file in files {
                let formData = MultipartFormData(provider: .file(file.file),
                                                 name: file.name,
                                                 fileName: file.fileName,
                                                 mimeType: file.mimeType)
                formDataArray.append(formData)
            }
        }

        guard let params = uploadConfig.params else {
            return .uploadMultipart(formDataArray)

        }
        return .uploadCompositeMultipart(formDataArray, urlParameters: params)
    }
}

