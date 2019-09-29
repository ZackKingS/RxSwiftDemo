//
//  IHRequestAdapter.swift
//  InternetHospital
//
//  Created by Trinity on 2019/5/27.
//  Copyright © 2019 GaoLian. All rights reserved.
//

import UIKit
import Alamofire

class IHRequestAdapter: RequestAdapter, Singleton {
    static func createSingleton() -> Any {
        return IHRequestAdapter()
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    
        
        var request = urlRequest
        
        let value = "hisee-app,HISEE_VERSION=\(IHAppConfiguration.shared().HISEE_VERSION),HISEE_PLATFROM=\(IHAppConfiguration.shared().HISEE_PLATFROM)"
        
        request.setValue(value, forHTTPHeaderField: "User-Agent")
        
        return request
    }
}


extension IHRequestAdapter: SwiftAwake {
    static func awake() {
        SessionManager.default.adapter = IHRequestAdapter.shared()
    }
}
