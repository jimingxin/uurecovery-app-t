//
//  APIConfig.swift
//  SwiftDemo
//
//  Created by zain guo on 2020/9/9.
//  Copyright © 2020 canshi. All rights reserved.
//

import UIKit

public enum APIEncodingType {
    case URL
    case JSON
}

public enum APIRequestMethod: String {
    case GET
    case POST
}

protocol APIConfigProtocol {
    
    var encodingType: APIEncodingType { get }
    var method: APIRequestMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var params: [String : Any]? { get }
    var headers: [String : String]? { get }
    var showloding: Bool { get }
}

public struct APIConfig: APIConfigProtocol {
    
    var encodingType: APIEncodingType = .URL
    
    var method: APIRequestMethod = .GET
    
    var baseURL: String = ""
    
    var path: String = ""
    
    var params: [String : Any]?
    
    var headers: [String : String]?
    
    var showloding: Bool = false
  
    
}
public struct UploadConfig: APIConfigProtocol {
    
    var encodingType: APIEncodingType = .URL
    
    var method: APIRequestMethod = .POST
    
    var baseURL: String = ""
    
    var path: String = ""
    
    var params: [String : Any]?
    
    var headers: [String : String]?
    
    var showloding: Bool = false
    
    var images: [UploadImage]?
    
    var files: [UploadFile]?
}

struct UploadImage {
    var image: UIImage!
    var name: String = ""
    var fileName: String = ""
    var mimeType: String = ""
}
struct UploadFile {
    var file: URL!
    var name: String = ""
    var fileName: String = ""
    var mimeType: String = ""
}

