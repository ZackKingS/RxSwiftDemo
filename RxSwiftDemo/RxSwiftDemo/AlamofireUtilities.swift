//
//  AlamofireUtilities.swift
//
//  Created by 高炼 on 2019/5/6.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamofireUtilities {
}

fileprivate struct JSONParameterEncoding: ParameterEncoding {
    var json: Any?
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let json = json else { return request }
        
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = data
        return request
    }
}

fileprivate struct RawDataParameterEncoding: ParameterEncoding {
    var data: Data?
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let data = data else { return request }
        
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = data
        return request
    }
}

extension AlamofireUtilities {
    static func post(_ url: IHURL, params: Parameters? = nil) -> DataRequest {
        return Alamofire.request(url, method: .post, parameters: params)
    }
    
    static func post<T: Codable>(_ url: IHURL, codable: T) -> DataRequest {
        return Alamofire.request(url, method: .post, encoding: RawDataParameterEncoding(data: try? JSONEncoder.shared().encode(codable)))
    }
    
    static func get(_ url: IHURL, params: Parameters? = nil) -> DataRequest {
        return Alamofire.request(url, method: .get, parameters: params)
    }
    
    static func get<T: Codable>(_ url: IHURL, codable: T) -> DataRequest {
        return Alamofire.request(url, method: .get, encoding: RawDataParameterEncoding(data: try? JSONEncoder.shared().encode(codable)))
    }
    
    static func method(_ method: HTTPMethod, url: IHURL, params: Parameters? = nil) -> DataRequest {
        return Alamofire.request(url, method: method, parameters: params)
    }
    
    static func method<T: Codable>(_ method: HTTPMethod, url: IHURL, codable: T) -> DataRequest {
        return Alamofire.request(url, method: method, encoding: RawDataParameterEncoding(data: try? JSONEncoder.shared().encode(codable)))
    }
}
